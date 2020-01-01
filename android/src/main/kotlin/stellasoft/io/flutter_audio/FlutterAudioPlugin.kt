package stellasoft.io.flutter_audio

import android.media.MediaPlayer
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.Exception

class FlutterAudioPlugin(private val registrar: Registrar): MethodCallHandler {

  private val methodChannel = MethodChannel(registrar.messenger(), "flutter_audio")
  private var mediaPlayer: MediaPlayer? = null

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val plugin = FlutterAudioPlugin(registrar)
      registrar.addViewDestroyListener { view ->
        plugin.onDestroy()
        false }
      plugin.startListening()
    }
  }

  fun startListening() {
    methodChannel.setMethodCallHandler(this)
  }

  fun stopListening() {
    methodChannel.setMethodCallHandler(null)
  }

  fun onDestroy() {

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "play" -> {
        try {
          val path = call.argument<String>("path")
          val assetManager = registrar.context().assets
          val key = registrar.lookupKeyForAsset(path)
          assetManager.openFd(key)
                  .use { fd ->
                    if (mediaPlayer != null) {
                      stop()
                    }
                    mediaPlayer = MediaPlayer()
                    mediaPlayer?.setDataSource(fd.fileDescriptor, fd.startOffset, fd.length)
                    mediaPlayer?.prepare()
                    mediaPlayer?.start()
                  }
        } catch (ex: Exception) {

        }
      }

      "stop" -> {
        stop()
      }

      "pause" -> {
        mediaPlayer?.pause()
      }

      else -> {
        result.notImplemented()
      }
    }

  }

  private fun stop() {
    mediaPlayer?.stop()
    mediaPlayer?.release()
    mediaPlayer = null
  }

}
