import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
	const AppShimmer({
		Key? key,
		this.width,
		this.height,
		this.baseColor = defaultBaseColor,
		this.highlightColor = defaultHighlightColor,
		this.shape = BoxShape.rectangle,
		this.borderRadius = 8.0,
		this.opacity = 1.0,
	})  : assert(opacity >= 0.0 && opacity <= 1.0),
				assert(shape != null),
				super(key: key);

	static const defaultBaseColor = Color(0xFFE4E4E4);
	static const defaultHighlightColor = Color(0xFFD1D1D1);

	final double? width;
	final double? height;

	final Color baseColor;
	final Color highlightColor;

	final BoxShape shape;
	final double borderRadius;
	final double opacity;

	@override
	Widget build(BuildContext context) {
		Color base = baseColor;
		Color hightlight = highlightColor;

		if (opacity < 1.0) {
			final hslFirstColor = HSLColor.fromColor(base);
			base = hslFirstColor.withAlpha(opacity).toColor();
			final hslSecondColor = HSLColor.fromColor(hightlight);
			hightlight = hslSecondColor.withAlpha(opacity).toColor();
		}

		return Shimmer.fromColors(
			baseColor: base,
			highlightColor: hightlight,
			child: Container(
				width: width,
				height: height,
				decoration: BoxDecoration(
					color: Colors.grey,
					shape: shape,
					borderRadius: shape != BoxShape.circle ? BorderRadius.circular(borderRadius) : null,
				),
			),
		);
	}
}
