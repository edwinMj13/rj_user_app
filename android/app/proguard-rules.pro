# Keep all classes and methods from the Razorpay library
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

## Keep ProGuard annotations if required by the SDKs
#-keep class proguard.annotation.Keep { *; }
#-keep class proguard.annotation.KeepClassMembers { *; }

# Avoid stripping out Flutter-related code
-keep class io.flutter.plugin.** { *; }
