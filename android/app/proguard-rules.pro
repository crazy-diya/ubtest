# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in F:\Software\AndroidDevelopmentStudio\Android\sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
-ignorewarnings
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}
-keep class com.huawei.hms.flutter.** { *; }

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
-repackageclasses
-keep class justpay.**  { *; }

-keep class org.xmlpull.v1.** { *;}
 -dontwarn org.xmlpull.v1.**

## Nineolddroid related classes to ignore
-keep class com.nineoldandroids.animation.** { *; }
-keep interface com.nineoldandroids.animation.** { *; }
-keep class com.nineoldandroids.view.** { *; }
-keep interface com.nineoldandroids.view.** { *; }



##JustPay
-dontwarn org.spongycastle.**
-keep class com.lankapay.justpay.** { *; }

### Retrofit 2
# Platform calls Class.forName on types which do not exist on Android to determine platform.
-dontnote retrofit2.Platform
# Platform used when running on RoboVM on iOS. Will not be used at runtime.
-dontnote retrofit2.Platform$IOS$MainThreadExecutor
# Platform used when running on Java 8 VMs. Will not be used at runtime.
-dontwarn retrofit2.Platform$Java8
# Retain generic type information for use by reflection by converters and adapters.
-keepattributes Signature
# Retain declared checked exceptions for use by a Proxy instance.
-keepattributes Exceptions

#JPOS
-dontwarn org.jpos.**

#bouncycastle
-dontwarn org.bouncycastle.**

#Google Services
-keep public class com.google.android.gms.* { public *; }
-dontwarn com.google.android.gms.**

### OkHttp3
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class com.squareup.okhttp3.** { *; }
-keep interface com.squareup.okhttp3.* { *; }
-keep class okhttp3.** { *; }
-dontwarn javax.annotation.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

-keepclassmembers,allowobfuscation class * { @com.google.gson.annotations.SerializedName <fields>; }
-keep,allowobfuscation @interface com.google.gson.annotations.SerializedName


-keep class com.wang.avi.** { *; }
-keep class com.wang.avi.indicators.** { *; }
-keep class androidx.appcompat.widget.** { *; }

#Huawei
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile, LineNumberTable
-keep class com.huawei.updatesdk.** {*; }
-keep class com.huawei.hms.** {*; }