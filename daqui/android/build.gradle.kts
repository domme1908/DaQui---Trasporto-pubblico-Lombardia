import org.gradle.api.Action
import org.gradle.api.Project
import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        kotlinOptions {
            jvmTarget = "1.8"
        }
    }

        subprojects {
        afterEvaluate {
            if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
                extensions.findByType(BaseExtension::class.java)?.let { androidExt ->
                    if (androidExt.namespace == null) {
                        androidExt.namespace = name
                    }
                }
            }
        }
    }

}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
