import java.util.Properties
import java.util.Base64
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

fun dartDefine(key: String, value: String): String {
    return Base64.getEncoder().encodeToString("$key=$value".toByteArray())
}

// Read local.properties (NOT committed)
val localProps = Properties()
val localPropsFile = rootProject.file("local.properties")
if (localPropsFile.exists()) {
    localProps.load(FileInputStream(localPropsFile))
}

val tmdbBearer = localProps.getProperty("tmdb.bearer", "").trim()
val tmdbBaseUrl = localProps.getProperty("tmdb.baseUrl", "").trim()
val tmdbImageBaseUrl = localProps.getProperty("tmdb.imageBaseUrl", "").trim()


val injectedDefines = buildList {
    if (tmdbBearer.isNotBlank()) add(dartDefine("TMDB_BEARER", tmdbBearer))
    add(dartDefine("TMDB_BASE_URL", tmdbBaseUrl))
    add(dartDefine("TMDB_IMAGE_BASE_URL", tmdbImageBaseUrl))
}.joinToString(",")


val existing = (project.findProperty("dart-defines") as String?)
    ?.takeIf { it.isNotBlank() }

val merged = listOfNotNull(
    existing,
    injectedDefines.takeIf { it.isNotBlank() }
).joinToString(",")

if (merged.isNotBlank()) {
    project.extensions.extraProperties["dart-defines"] = merged
}


android {
    namespace = "com.example.tmdb_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.tmdb_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
        }
        create("prod") {
            dimension = "env"
        }
    }
}


flutter {
    source = "../.."
}
