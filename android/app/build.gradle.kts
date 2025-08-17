apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'com.google.gms.google-services'  // Add this line

android {
    namespace "com.example.leakpeek"
    compileSdkVersion 34

    defaultConfig {
        applicationId "com.example.leakpeek"
        minSdkVersion 21  // Firebase requires minimum API 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0"
        multiDexEnabled true  // Add this if you encounter dex limit
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation 'com.android.support:multidex:1.0.3'  // Add if needed
}