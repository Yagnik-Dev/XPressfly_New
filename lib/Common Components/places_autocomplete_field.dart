import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:xpressfly_git/Utility/common_imports.dart';
import 'package:xpressfly_git/Utility/place_service.dart';

class GooglePlacesTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final Function(PlaceDetails) onPlaceSelected;
  final String? Function(String?)? validator;
  final String googleAPIKey;

  const GooglePlacesTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.onPlaceSelected,
    this.validator,
    this.googleAPIKey = "AIzaSyBk6ueDJ7vlhRhSs9XOIlt6j0XRmIrA4co",
  });

  @override
  State<GooglePlacesTextField> createState() => _GooglePlacesTextFieldState();
}

class _GooglePlacesTextFieldState extends State<GooglePlacesTextField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Timer? _debounce;
  List<PlacePrediction> _predictions = [];
  bool _isLoading = false;
  String _sessionToken = '';
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _generateSessionToken();
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _generateSessionToken() {
    _sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (widget.controller.text.isEmpty) {
      _removeOverlay();
      setState(() {
        _predictions.clear();
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _fetchPlaces(widget.controller.text);
    });
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _removeOverlay();
      });
    }
  }

  Future<void> _fetchPlaces(String input) async {
    if (input.isEmpty) return;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=${Uri.encodeComponent(input)}'
      '&key=${widget.googleAPIKey}'
      '&sessiontoken=$_sessionToken'
      '&components=country:in'
      '&language=en',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print('API Response Status: ${data['status']}');
        print('Predictions count: ${data['predictions']?.length ?? 0}');

        if (data['status'] == 'OK') {
          final predictions =
              (data['predictions'] as List)
                  .map((e) => PlacePrediction.fromJson(e))
                  .toList();

          if (mounted) {
            setState(() {
              _predictions = predictions;
              _isLoading = false;
            });

            if (predictions.isNotEmpty && _focusNode.hasFocus) {
              _showOverlay();
            } else {
              _removeOverlay();
            }
          }
        } else {
          print('API Error: ${data['status']}');
          if (mounted) {
            setState(() {
              _predictions = [];
              _isLoading = false;
            });
          }
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching places: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _predictions = [];
        });
      }
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&key=${widget.googleAPIKey}'
      '&sessiontoken=$_sessionToken'
      '&fields=geometry,formatted_address,address_components',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final placeDetails = PlaceDetails.fromJson(data['result']);

          // Generate new session token after place details request
          _generateSessionToken();

          // Call the callback with place details
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onPlaceSelected(placeDetails);
          });
        }
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }
  }

  void _showOverlay() {
    _removeOverlay();

    // Get the RenderBox and size BEFORE creating the OverlayEntry
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                constraints: BoxConstraints(maxHeight: 250.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _predictions.length,
                  separatorBuilder:
                      (context, index) =>
                          const Divider(height: 1, thickness: 0.5),
                  itemBuilder: (context, index) {
                    final prediction = _predictions[index];
                    return InkWell(
                      onTap: () {
                        widget.controller.text = prediction.description;
                        widget
                            .controller
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description.length),
                        );
                        _getPlaceDetails(prediction.placeId);
                        _removeOverlay();
                        _focusNode.unfocus();
                        setState(() => _predictions.clear());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                prediction.description,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _removeOverlay();
    widget.controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
          // borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
          // borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
          // borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        suffixIcon:
            _isLoading
                ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : widget.controller.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    widget.controller.clear();
                    _removeOverlay();
                    setState(() => _predictions.clear());
                  },
                )
                : null,
      ),
    );
  }
}
