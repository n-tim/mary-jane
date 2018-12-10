import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtQuick.Dialogs 1.2

Page {
    property var stack: null
    ColumnLayout {
        anchors.fill: parent

        Camera {
          id: camera

          imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

          exposure {
              exposureCompensation: -1.0
              exposureMode: Camera.ExposurePortrait
          }

          flash.mode: Camera.FlashRedEyeReduction

          imageCapture {
              onImageCaptured: {
                  photoPreview.source = preview  // Show the preview in an Image
              }
          }
        }

        VideoOutput {
          source: camera
          Layout.fillWidth: true
          Layout.minimumHeight: width
          focus : visible // to receive focus and capture key events when visible
        }

        Image {
          id: photoPreview
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "capture"
            onClicked: {
                maryJane.cameraButtonPressed();
                //preview.source = maryJane.getImagePath();
            }
        }
    }
}
