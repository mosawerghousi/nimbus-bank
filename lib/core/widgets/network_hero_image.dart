import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../extensions/context_extensions.dart';

/// Cached network image wired up with a tasteful shimmer placeholder
/// and a subtle error state.
///
/// On the web, `cached_network_image` (via flutter_cache_manager) does not
/// decode reliably under the CanvasKit renderer, so we fall back to a plain
/// [Image.network] there. On mobile we keep CachedNetworkImage for its disk
/// caching benefits.
class NetworkHeroImage extends StatelessWidget {
  const NetworkHeroImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final Widget image = kIsWeb
        ? Image.network(
            url,
            fit: fit,
            height: height,
            width: width,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) return child;
              return Container(
                color: context.colors.surface,
                height: height,
                width: width,
              );
            },
            errorBuilder: (context, _, _) => _error(context),
          )
        : CachedNetworkImage(
            imageUrl: url,
            fit: fit,
            height: height,
            width: width,
            placeholder: (context, _) => Shimmer.fromColors(
              baseColor: context.colors.surface,
              highlightColor: context.colors.surfaceElevated,
              child: Container(
                color: context.colors.surface,
                height: height,
                width: width,
              ),
            ),
            errorWidget: (context, _, _) => _error(context),
          );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }

  Widget _error(BuildContext context) => Container(
        color: context.colors.surface,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: context.colors.textMuted,
        ),
      );
}
