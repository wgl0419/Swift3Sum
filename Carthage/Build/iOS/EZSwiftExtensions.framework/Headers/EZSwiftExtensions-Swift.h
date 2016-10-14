// Generated by Apple Swift version 3.0 (swiftlang-800.0.46.2 clang-800.0.38)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import ObjectiveC;
@import Foundation;
@import CoreFoundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class CALayer;
@class NSCoder;

/**
  Make sure you use  “[weak self] (sender) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions11BlockButton")
@interface BlockButton : UIButton
@property (nonatomic, strong) CALayer * _Nullable highlightLayer;
@property (nonatomic, copy) void (^ _Nullable action)(BlockButton * _Nonnull);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h action:(void (^ _Nullable)(BlockButton * _Nonnull))action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAction:(void (^ _Nonnull)(BlockButton * _Nonnull))action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame action:(void (^ _Nonnull)(BlockButton * _Nonnull))action OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)addAction:(void (^ _Nonnull)(BlockButton * _Nonnull))action;
- (void)didPressed:(BlockButton * _Nonnull)sender;
- (void)highlight;
- (void)unhighlight;
@end


/**
  Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions14BlockLongPress")
@interface BlockLongPress : UILongPressGestureRecognizer
- (nonnull instancetype)initWithTarget:(id _Nullable)target action:(SEL _Nullable)action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAction:(void (^ _Nullable)(UILongPressGestureRecognizer * _Nonnull))action;
- (void)didLongPressed:(UILongPressGestureRecognizer * _Nonnull)longPress;
@end


/**
  Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions8BlockPan")
@interface BlockPan : UIPanGestureRecognizer
- (nonnull instancetype)initWithTarget:(id _Nullable)target action:(SEL _Nullable)action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAction:(void (^ _Nullable)(UIPanGestureRecognizer * _Nonnull))action;
- (void)didPan:(UIPanGestureRecognizer * _Nonnull)pan;
@end


/**
  Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions10BlockPinch")
@interface BlockPinch : UIPinchGestureRecognizer
- (nonnull instancetype)initWithTarget:(id _Nullable)target action:(SEL _Nullable)action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAction:(void (^ _Nullable)(UIPinchGestureRecognizer * _Nonnull))action;
- (void)didPinch:(UIPinchGestureRecognizer * _Nonnull)pinch;
@end


/**
  Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions10BlockSwipe")
@interface BlockSwipe : UISwipeGestureRecognizer
- (nonnull instancetype)initWithTarget:(id _Nullable)target action:(SEL _Nullable)action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithDirection:(UISwipeGestureRecognizerDirection)direction fingerCount:(NSInteger)fingerCount action:(void (^ _Nullable)(UISwipeGestureRecognizer * _Nonnull))action;
- (void)didSwipe:(UISwipeGestureRecognizer * _Nonnull)swipe;
@end


/**
  Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions8BlockTap")
@interface BlockTap : UITapGestureRecognizer
- (nonnull instancetype)initWithTarget:(id _Nullable)target action:(SEL _Nullable)action OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithTapCount:(NSInteger)tapCount fingerCount:(NSInteger)fingerCount action:(void (^ _Nullable)(UITapGestureRecognizer * _Nonnull))action;
- (void)didTap:(UITapGestureRecognizer * _Nonnull)tap;
@end


/**
  Make sure you use  \code
  [weak self] (NSURLRequest) in
  \endcode if you are using the keyword \code
  self
  \endcode inside the closure or there might be a memory leak
*/
SWIFT_CLASS("_TtC17EZSwiftExtensions12BlockWebView")
@interface BlockWebView : UIWebView <UIWebViewDelegate>
@property (nonatomic, copy) void (^ _Nullable didStartLoad)(NSURLRequest * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable didFinishLoad)(NSURLRequest * _Nonnull);
@property (nonatomic, copy) void (^ _Nullable didFailLoad)(NSURLRequest * _Nonnull, NSError * _Nonnull);
@property (nonatomic, copy) BOOL (^ _Nullable shouldStartLoadingRequest)(NSURLRequest * _Nonnull);
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)webViewDidStartLoad:(UIWebView * _Nonnull)webView;
- (void)webViewDidFinishLoad:(UIWebView * _Nonnull)webView;
- (void)webView:(UIWebView * _Nonnull)webView didFailLoadWithError:(NSError * _Nonnull)error;
- (BOOL)webView:(UIWebView * _Nonnull)webView shouldStartLoadWithRequest:(NSURLRequest * _Nonnull)request navigationType:(UIWebViewNavigationType)navigationType;
@end


@interface NSBundle (SWIFT_EXTENSION(EZSwiftExtensions))
+ (void)loadNib:(NSString * _Nonnull)name owner:(id _Null_unspecified)owner;
@end

@class UIColor;

@interface NSAttributedString (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Adds bold attribute to NSAttributedString and returns it
*/
- (NSAttributedString * _Nonnull)bold;
/**
  EZSE: Adds underline attribute to NSAttributedString and returns it
*/
- (NSAttributedString * _Nonnull)underline;
/**
  EZSE: Adds italic attribute to NSAttributedString and returns it
*/
- (NSAttributedString * _Nonnull)italic;
/**
  EZSE: Adds strikethrough attribute to NSAttributedString and returns it
*/
- (NSAttributedString * _Nonnull)strikethrough;
/**
  EZSE: Adds color attribute to NSAttributedString and returns it
*/
- (NSAttributedString * _Nonnull)color:(UIColor * _Nonnull)color;
@end


@interface NSDictionary (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Unserialize JSON string into NSDictionary
*/
- (nullable instancetype)initWithJson:(NSString * _Nonnull)json;
/**
  EZSE: Serialize NSDictionary into JSON string
*/
- (NSString * _Nullable)formatJSON;
@end


@interface NSObject (SWIFT_EXTENSION(EZSwiftExtensions))
@property (nonatomic, readonly, copy) NSString * _Nonnull className;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull className;)
+ (NSString * _Nonnull)className;
@end

@class OS_dispatch_queue;

@interface NSTimer (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Runs every x seconds, to cancel use: timer.invalidate()
*/
+ (NSTimer * _Nonnull)runThisEveryWithSeconds:(NSTimeInterval)seconds handler:(void (^ _Nonnull)(CFRunLoopTimerRef _Nullable))handler;
/**
  EZSE: Run function after x seconds
*/
+ (void)runThisAfterDelayWithSeconds:(double)seconds after:(void (^ _Nonnull)(void))after;
/**
  EZSwiftExtensions - dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
*/
+ (void)runThisAfterDelayWithSeconds:(double)seconds queue:(OS_dispatch_queue * _Nonnull)queue after:(void (^ _Nonnull)(void))after;
@end


@interface UIAlertController (SWIFT_EXTENSION(EZSwiftExtensions))
@end

@class UIViewController;

@interface UIApplication (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Run a block in background after app resigns activity
*/
- (void)runInBackground:(void (^ _Nonnull)(void))closure expirationHandler:(void (^ _Nullable)(void))expirationHandler;
/**
  EZSE: Get the top most view controller from the base view controller; default param is UIWindow’s rootViewController
*/
+ (UIViewController * _Nullable)topViewController:(UIViewController * _Nullable)base;
@end


@interface UIBarButtonItem (SWIFT_EXTENSION(EZSwiftExtensions))
@end


@interface UIButton (SWIFT_EXTENSION(EZSwiftExtensions))
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h target:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions
*/
- (void)setBackgroundColor:(UIColor * _Nonnull)color forState:(UIControlState)forState;
@end


@interface UIColor (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
*/
- (nonnull instancetype)initWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;
/**
  EZSE: init method with hex string and alpha(default: 1)
*/
- (nullable instancetype)initWithHexString:(NSString * _Nonnull)hexString alpha:(CGFloat)alpha;
/**
  EZSE: init method from Gray value and alpha(default:1)
*/
- (nonnull instancetype)initWithGray:(CGFloat)gray alpha:(CGFloat)alpha;
/**
  EZSE: Red component of UIColor (get-only)
*/
@property (nonatomic, readonly) NSInteger redComponent;
/**
  EZSE: Green component of UIColor (get-only)
*/
@property (nonatomic, readonly) NSInteger greenComponent;
/**
  EZSE: blue component of UIColor (get-only)
*/
@property (nonatomic, readonly) NSInteger blueComponent;
/**
  EZSE: Alpha of UIColor (get-only)
*/
@property (nonatomic, readonly) CGFloat alpha;
/**
  EZSE: Returns random UIColor with random alpha(default: false)
*/
+ (UIColor * _Nonnull)randomColor:(BOOL)randomAlpha;
@end


@interface UIDevice (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
+ (NSString * _Nullable)idForVendor;
/**
  EZSwiftExtensions - Operating system name
*/
+ (NSString * _Nonnull)systemName;
/**
  EZSwiftExtensions - Operating system version
*/
+ (NSString * _Nonnull)systemVersion;
/**
  EZSwiftExtensions - Operating system version
*/
+ (float)systemFloatVersion;
/**
  EZSwiftExtensions
*/
+ (NSString * _Nonnull)deviceName;
/**
  EZSwiftExtensions
*/
+ (NSString * _Nonnull)deviceLanguage;
/**
  EZSwiftExtensions
*/
+ (NSString * _Nonnull)deviceModelReadable;
/**
  EZSE: Returns true if the device is iPhone //TODO: Add to readme
*/
+ (BOOL)isPhone;
/**
  EZSE: Returns true if the device is iPad //TODO: Add to readme
*/
+ (BOOL)isPad;
/**
  EZSwiftExtensions
*/
+ (NSString * _Nonnull)deviceModel;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull CURRENT_VERSION;)
+ (NSString * _Nonnull)CURRENT_VERSION;
+ (BOOL)IS_OS_5;
+ (BOOL)IS_OS_5_OR_LATER;
+ (BOOL)IS_OS_5_OR_EARLIER;
+ (BOOL)IS_OS_6;
+ (BOOL)IS_OS_6_OR_LATER;
+ (BOOL)IS_OS_6_OR_EARLIER;
+ (BOOL)IS_OS_7;
+ (BOOL)IS_OS_7_OR_LATER;
+ (BOOL)IS_OS_7_OR_EARLIER;
+ (BOOL)IS_OS_8;
+ (BOOL)IS_OS_8_OR_LATER;
+ (BOOL)IS_OS_8_OR_EARLIER;
+ (BOOL)IS_OS_9;
+ (BOOL)IS_OS_9_OR_LATER;
+ (BOOL)IS_OS_9_OR_EARLIER;
/**
  EZSwiftExtensions
*/
+ (BOOL)isSystemVersionOver:(NSString * _Nonnull)requiredVersion;
@end


@interface UIFont (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
+ (UIFont * _Nonnull)AvenirNextDemiBoldWithSize:(CGFloat)size;
/**
  EZSwiftExtensions
*/
+ (UIFont * _Nonnull)AvenirNextRegularWithSize:(CGFloat)size;
@end


@interface UIImage (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Returns compressed image to rate from 0 to 1
*/
- (NSData * _Nullable)compressImageWithRate:(CGFloat)rate;
/**
  EZSE: Returns Image size in Bytes
*/
- (NSInteger)getSizeAsBytes;
/**
  EZSE: Returns Image size in Kylobites
*/
- (NSInteger)getSizeAsKilobytes;
/**
  EZSE: scales image
*/
+ (UIImage * _Nonnull)scaleToImage:(UIImage * _Nonnull)image w:(CGFloat)w h:(CGFloat)h;
/**
  EZSE Returns resized image with width. Might return low quality
*/
- (UIImage * _Nonnull)resizeWithWidth:(CGFloat)width;
/**
  EZSE Returns resized image with height. Might return low quality
*/
- (UIImage * _Nonnull)resizeWithHeight:(CGFloat)height;
/**
  EZSE:
*/
- (CGFloat)aspectHeightForWidth:(CGFloat)width;
/**
  EZSE:
*/
- (CGFloat)aspectWidthForHeight:(CGFloat)height;
/**
  EZSE: Returns cropped image from CGRect
*/
- (UIImage * _Nullable)croppedImage:(CGRect)bound;
/**
  EZSE: Use current image for pattern of color
*/
- (UIImage * _Nonnull)withColor:(UIColor * _Nonnull)tintColor;
/**
  EZSE: Returns the image associated with the URL
*/
- (nullable instancetype)initWithUrlString:(NSString * _Nonnull)urlString;
/**
  EZSE: Returns an empty image //TODO: Add to readme
*/
+ (UIImage * _Nonnull)blankImage;
@end


@interface UIImageView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h imageName:(NSString * _Nonnull)imageName;
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y imageName:(NSString * _Nonnull)imageName scaleToWidth:(CGFloat)scaleToWidth;
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h image:(UIImage * _Nonnull)image;
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y image:(UIImage * _Nonnull)image scaleToWidth:(CGFloat)scaleToWidth;
/**
  EZSwiftExtensions, scales this ImageView size to fit the given width
*/
- (void)scaleImageFrameToWidthWithWidth:(CGFloat)width;
/**
  EZSwiftExtensions, scales this ImageView size to fit the given height
*/
- (void)scaleImageFrameToHeightWithHeight:(CGFloat)height;
/**
  EZSwiftExtensions
*/
- (void)roundSquareImage;
/**
  EZSwiftExtensions
*/
- (void)imageWithUrlWithUrl:(NSString * _Nonnull)url;
/**
  EZSwiftExtensions
*/
- (void)imageWithUrlWithUrl:(NSString * _Nonnull)url placeholder:(UIImage * _Nonnull)placeholder;
/**
  EZSwiftExtensions
*/
- (void)imageWithUrlWithUrl:(NSString * _Nonnull)url placeholderNamed:(NSString * _Nonnull)placeholderNamed;
@end


@interface UILabel (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions: fontSize: 17
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h fontSize:(CGFloat)fontSize;
/**
  EZSwiftExtensions
*/
- (CGSize)getEstimatedSize:(CGFloat)width height:(CGFloat)height;
/**
  EZSwiftExtensions
*/
- (CGFloat)getEstimatedHeight;
/**
  EZSwiftExtensions
*/
- (CGFloat)getEstimatedWidth;
/**
  EZSwiftExtensions
*/
- (void)fitHeight;
/**
  EZSwiftExtensions
*/
- (void)fitWidth;
/**
  EZSwiftExtensions
*/
- (void)fitSize;
@end


@interface UISlider (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Slider moving to value with animation duration
*/
- (void)setValue:(float)value duration:(double)duration;
@end


@interface UIStoryboard (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Get the application’s main storyboard
  Usage: let storyboard = UIStoryboard.mainStoryboard
*/
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UIStoryboard * _Nullable mainStoryboard;)
+ (UIStoryboard * _Nullable)mainStoryboard;
@end


@interface UISwitch (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: toggles Switch
*/
- (void)toggle;
@end


@interface UITextField (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
  textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName, fontsize = 17
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
/**
  EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
  textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h fontSize:(CGFloat)fontSize;
/**
  EZSE: Add left padding to the text in textfield
*/
- (void)addLeftTextPadding:(CGFloat)blankSize;
/**
  EZSE: Add a image icon on the left side of the textfield
*/
- (void)addLeftIcon:(UIImage * _Nullable)image frame:(CGRect)frame imageSize:(CGSize)imageSize;
@end


@interface UITextView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
  textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName, fontsize = 17
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
/**
  EZSwiftExtensions: Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
  textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h fontSize:(CGFloat)fontSize;
/**
  EZSE: Automatically adds a toolbar with a done button to the top of the keyboard. Tapping the button will dismiss the keyboard.
*/
- (void)addDoneButton:(UIBarStyle)barStyle title:(NSString * _Nullable)title;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Shakes the view for as many number of times as given in the argument.
*/
- (void)shakeViewForTimes:(NSInteger)times;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (UIImage * _Nonnull)toImage;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions [UIRectCorner.TopLeft, UIRectCorner.TopRight]
*/
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
/**
  EZSwiftExtensions
*/
- (void)roundView;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (nonnull instancetype)initWithX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;
/**
  EZSwiftExtensions, puts padding around the view
*/
- (nonnull instancetype)initWithSuperView:(UIView * _Nonnull)superView padding:(CGFloat)padding;
/**
  EZSwiftExtensions - Copies size of superview
*/
- (nonnull instancetype)initWithSuperView:(UIView * _Nonnull)superView;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (void)setRotationX:(CGFloat)x;
/**
  EZSwiftExtensions
*/
- (void)setRotationY:(CGFloat)y;
/**
  EZSwiftExtensions
*/
- (void)setRotationZ:(CGFloat)z;
/**
  EZSwiftExtensions
*/
- (void)setRotationWithX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;
/**
  EZSwiftExtensions
*/
- (void)setScaleWithX:(CGFloat)x y:(CGFloat)y;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (void)springWithAnimations:(void (^ _Nonnull)(void))animations completion:(void (^ _Nullable)(BOOL))completion;
/**
  EZSwiftExtensions
*/
- (void)springWithDuration:(NSTimeInterval)duration animations:(void (^ _Nonnull)(void))animations completion:(void (^ _Nullable)(BOOL))completion;
/**
  EZSwiftExtensions
*/
- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^ _Nonnull)(void))animations completion:(void (^ _Nullable)(BOOL))completion;
/**
  EZSwiftExtensions
*/
- (void)animateWithAnimations:(void (^ _Nonnull)(void))animations completion:(void (^ _Nullable)(BOOL))completion;
/**
  EZSwiftExtensions
*/
- (void)pop;
/**
  EZSwiftExtensions
*/
- (void)popBig;
- (void)reversePop;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions
*/
- (void)setCornerRadiusWithRadius:(CGFloat)radius;
/**
  EZSwiftExtensions
*/
- (void)addBorderWithWidth:(CGFloat)width color:(UIColor * _Nonnull)color;
/**
  EZSwiftExtensions
*/
- (void)addBorderTopWithSize:(CGFloat)size color:(UIColor * _Nonnull)color;
/**
  EZSwiftExtensions
*/
- (void)addBorderTopWithPaddingWithSize:(CGFloat)size color:(UIColor * _Nonnull)color padding:(CGFloat)padding;
/**
  EZSwiftExtensions
*/
- (void)addBorderBottomWithSize:(CGFloat)size color:(UIColor * _Nonnull)color;
/**
  EZSwiftExtensions
*/
- (void)addBorderLeftWithSize:(CGFloat)size color:(UIColor * _Nonnull)color;
/**
  EZSwiftExtensions
*/
- (void)addBorderRightWithSize:(CGFloat)size color:(UIColor * _Nonnull)color;
/**
  EZSwiftExtensions
*/
- (void)drawCircleWithFillColor:(UIColor * _Nonnull)fillColor strokeColor:(UIColor * _Nonnull)strokeColor strokeWidth:(CGFloat)strokeWidth;
/**
  EZSwiftExtensions
*/
- (void)drawStrokeWithWidth:(CGFloat)width color:(UIColor * _Nonnull)color;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
  EZSwiftExtensions
*/
- (void)addTapGestureWithTapNumber:(NSInteger)tapNumber target:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions - Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
- (void)addTapGestureWithTapNumber:(NSInteger)tapNumber action:(void (^ _Nullable)(UITapGestureRecognizer * _Nonnull))action;
/**
  EZSwiftExtensions
*/
- (void)addSwipeGestureWithDirection:(UISwipeGestureRecognizerDirection)direction numberOfTouches:(NSInteger)numberOfTouches target:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions - Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
- (void)addSwipeGestureWithDirection:(UISwipeGestureRecognizerDirection)direction numberOfTouches:(NSInteger)numberOfTouches action:(void (^ _Nullable)(UISwipeGestureRecognizer * _Nonnull))action;
/**
  EZSwiftExtensions
*/
- (void)addPanGestureWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions - Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
- (void)addPanGestureWithAction:(void (^ _Nullable)(UIPanGestureRecognizer * _Nonnull))action;
/**
  EZSwiftExtensions
*/
- (void)addPinchGestureWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions - Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
- (void)addPinchGestureWithAction:(void (^ _Nullable)(UIPinchGestureRecognizer * _Nonnull))action;
/**
  EZSwiftExtensions
*/
- (void)addLongPressGestureWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action;
/**
  EZSwiftExtensions - Make sure you use  “[weak self] (gesture) in” if you are using the keyword self inside the closure or there might be a memory leak
*/
- (void)addLongPressGestureWithAction:(void (^ _Nullable)(UILongPressGestureRecognizer * _Nonnull))action;
@end


@interface UIView (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSwiftExtensions, add multiple subviews
*/
- (void)addSubviews:(NSArray<UIView *> * _Nonnull)views;
/**
  EZSwiftExtensions, resizes this view so it fits the largest subview
*/
- (void)resizeToFitSubviews;
/**
  EZSwiftExtensions, resizes this view so it fits the largest subview
*/
- (void)resizeToFitSubviews:(NSArray<NSNumber *> * _Nonnull)tagsToIgnore;
/**
  EZSwiftExtensions
*/
- (void)resizeToFitWidth;
/**
  EZSwiftExtensions
*/
- (void)resizeToFitHeight;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat x;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat y;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat w;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat h;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat left;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat right;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat top;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat bottom;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGPoint origin;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat centerX;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGFloat centerY;
/**
  EZSwiftExtensions
*/
@property (nonatomic) CGSize size;
/**
  EZSwiftExtensions
*/
- (CGFloat)leftOffset:(CGFloat)offset;
/**
  EZSwiftExtensions
*/
- (CGFloat)rightOffset:(CGFloat)offset;
/**
  EZSwiftExtensions
*/
- (CGFloat)topOffset:(CGFloat)offset;
/**
  EZSwiftExtensions
*/
- (CGFloat)bottomOffset:(CGFloat)offset;
/**
  EZSwiftExtensions
*/
- (CGFloat)alignRight:(CGFloat)offset;
/**
  EZSwiftExtensions
*/
- (CGFloat)reorderSubViews:(BOOL)reorder tagsToIgnore:(NSArray<NSNumber *> * _Nonnull)tagsToIgnore;
- (void)removeSubviews;
/**
  EZSE: Centers view in superview horizontally
*/
- (void)centerXInSuperView;
/**
  EZSE: Centers view in superview vertically
*/
- (void)centerYInSuperView;
/**
  EZSE: Centers view in superview horizontally & vertically
*/
- (void)centerInSuperView;
@end

@class UINavigationBar;

@interface UIViewController (SWIFT_EXTENSION(EZSwiftExtensions))
- (void)addNotificationObserver:(NSString * _Nonnull)name selector:(SEL _Nonnull)selector;
- (void)removeNotificationObserver:(NSString * _Nonnull)name;
- (void)removeNotificationObserver;
- (void)addKeyboardWillShowNotification;
- (void)addKeyboardDidShowNotification;
- (void)addKeyboardWillHideNotification;
- (void)addKeyboardDidHideNotification;
- (void)removeKeyboardWillShowNotification;
- (void)removeKeyboardDidShowNotification;
- (void)removeKeyboardWillHideNotification;
- (void)removeKeyboardDidHideNotification;
- (void)keyboardDidShowNotification:(NSNotification * _Nonnull)notification;
- (void)keyboardWillShowNotification:(NSNotification * _Nonnull)notification;
- (void)keyboardWillHideNotification:(NSNotification * _Nonnull)notification;
- (void)keyboardDidHideNotification:(NSNotification * _Nonnull)notification;
- (void)keyboardWillShowWithFrame:(CGRect)frame;
- (void)keyboardDidShowWithFrame:(CGRect)frame;
- (void)keyboardWillHideWithFrame:(CGRect)frame;
- (void)keyboardDidHideWithFrame:(CGRect)frame;
- (void)hideKeyboardWhenTappedAround;
- (void)dismissKeyboard;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly) CGFloat top;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly) CGFloat bottom;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly) CGFloat tabBarHeight;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly) CGFloat navigationBarHeight;
/**
  EZSwiftExtensions
*/
@property (nonatomic, strong) UIColor * _Nullable navigationBarColor;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly, strong) UINavigationBar * _Nullable navBar;
/**
  EZSwiftExtensions
*/
@property (nonatomic, readonly) CGRect applicationFrame;
/**
  EZSwiftExtensions
*/
- (void)pushVC:(UIViewController * _Nonnull)vc;
/**
  EZSwiftExtensions
*/
- (void)popVC;
/**
  EZSwiftExtensions
*/
- (void)presentVC:(UIViewController * _Nonnull)vc;
/**
  EZSwiftExtensions
*/
- (void)dismissVCWithCompletion:(void (^ _Nullable)(void))completion;
/**
  EZSwiftExtensions
*/
- (void)addAsChildViewController:(UIViewController * _Nonnull)vc toView:(UIView * _Nonnull)toView;
@end


@interface UIWindow (SWIFT_EXTENSION(EZSwiftExtensions))
/**
  EZSE: Creates and shows UIWindow. The size will show iPhone4 size until you add launch images with proper sizes. TODO: Add to readme
*/
- (nonnull instancetype)initWithViewController:(UIViewController * _Nonnull)viewController backgroundColor:(UIColor * _Nonnull)backgroundColor;
@end


@interface NSUserDefaults (SWIFT_EXTENSION(EZSwiftExtensions))
- (id _Nullable)objectForKeyedSubscript:(NSString * _Nonnull)key;
- (void)setObject:(id _Nullable)newValue forKeyedSubscript:(NSString * _Nonnull)key;
@end

#pragma clang diagnostic pop