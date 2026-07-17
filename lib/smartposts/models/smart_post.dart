import 'package:equatable/equatable.dart';

import '../../common/app_constants.dart';
import '../../common/app_strings.dart';

final class SharePlatform extends Equatable {
  const SharePlatform({
    required this.name,
    required this.assetPath,
    this.innerPadding = 0,
  });

  final String name;
  final String assetPath;
  final double innerPadding;

  @override
  List<Object?> get props => <Object?>[name, assetPath, innerPadding];
}

final class ProductPromotion extends Equatable {
  const ProductPromotion({
    required this.name,
    required this.price,
    required this.discount,
    required this.imagePath,
  });

  final String name;
  final String price;
  final String discount;
  final String imagePath;

  @override
  List<Object?> get props => <Object?>[name, price, discount, imagePath];
}

final class SmartPost extends Equatable {
  const SmartPost({
    required this.backgroundAsset,
    required this.caption,
    required this.songTitle,
    required this.songArtist,
    required this.profileAsset,
    required this.referralCode,
    required this.referralLink,
    this.product,
  });

  final String backgroundAsset;
  final String caption;
  final String songTitle;
  final String songArtist;
  final String profileAsset;
  final String referralCode;
  final String referralLink;
  final ProductPromotion? product;

  SmartPost copyWith({String? caption}) {
    return SmartPost(
      backgroundAsset: backgroundAsset,
      caption: caption ?? this.caption,
      songTitle: songTitle,
      songArtist: songArtist,
      profileAsset: profileAsset,
      referralCode: referralCode,
      referralLink: referralLink,
      product: product,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    backgroundAsset,
    caption,
    songTitle,
    songArtist,
    profileAsset,
    referralCode,
    referralLink,
    product,
  ];
}

abstract final class SmartPostFixtures {
  static const product = ProductPromotion(
    name: AppStrings.productName,
    price: AppStrings.productPrice,
    discount: AppStrings.productDiscount,
    imagePath: AppAssets.productThumbnail,
  );

  static const posts = <SmartPost>[
    SmartPost(
      backgroundAsset: AppAssets.lipstickPost,
      caption: AppStrings.postOneCaption,
      songTitle: AppStrings.badHabits,
      songArtist: AppStrings.edSheeran,
      profileAsset: AppAssets.profile,
      referralCode: AppStrings.referralCode,
      referralLink: AppStrings.referralLink,
      product: product,
    ),
    SmartPost(
      backgroundAsset: AppAssets.perfumePost,
      caption: AppStrings.postTwoCaption,
      songTitle: AppStrings.unstoppable,
      songArtist: AppStrings.sia,
      profileAsset: AppAssets.profile,
      referralCode: AppStrings.referralCode,
      referralLink: AppStrings.referralLink,
    ),
    SmartPost(
      backgroundAsset: AppAssets.mascaraPost,
      caption: AppStrings.postThreeCaption,
      songTitle: AppStrings.vogue,
      songArtist: AppStrings.madonna,
      profileAsset: AppAssets.profile,
      referralCode: AppStrings.referralCode,
      referralLink: AppStrings.referralLink,
    ),
  ];

  static const sharePlatforms = <SharePlatform>[
    SharePlatform(
      name: AppStrings.instagram,
      assetPath: AppAssets.instagram,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.instagramStories,
      assetPath: AppAssets.instagram,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.facebook,
      assetPath: AppAssets.facebook,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.facebookStories,
      assetPath: AppAssets.facebook,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.messenger,
      assetPath: AppAssets.messenger,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.tikTok,
      assetPath: AppAssets.tikTok,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.whatsApp,
      assetPath: AppAssets.whatsApp,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.whatsAppBusiness,
      assetPath: AppAssets.whatsAppBusiness,
      innerPadding: AppConstants.four,
    ),
    SharePlatform(
      name: AppStrings.telegram,
      assetPath: AppAssets.telegram,
      innerPadding: AppConstants.four,
    ),
  ];
}
