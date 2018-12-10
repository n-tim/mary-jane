package org.maryJane;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;
import org.qtproject.qt5.android.QtNative;

import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;

import android.hardware.camera2.*;
import android.media.*;
import android.os.*;

import android.media.MediaScannerConnection.MediaScannerConnectionClient;
import android.media.MediaScannerConnection;

import android.graphics.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AndroidUtils extends QtActivity
{

    public static native void fileSelected(String fileName);
    public static native void photoTaken(String fileName);
    public static native void galleryUpdated(String fileName);

    static final int REQUEST_OPEN_IMAGE = 1;
    static final int REQUEST_TAKE_PHOTO = 3;
    final static int PICK_PHOTO_CODE = 1046;

    private static AndroidUtils m_instance;

    String mCurrentPhotoPath;

    // private MediaScannerConnection mediaScannerConnection;
    // private MediaScannerConnectionClient mediaScannerConnectionClient = 
    //     new MediaScannerConnectionClient() {

    //     @Override
    //     public void onMediaScannerConnected() {
    //         mediaScannerConnection.scanFile(mCurrentPhotoPath, null);
    //     }

    //     @Override
    //     public void onScanCompleted(String path, Uri uri) {
    //         if(path.equals(mCurrentPhotoPath))
    //             mediaScannerConnection.disconnect();
    //             photoTaken(mCurrentPhotoPath);
    //     }
    // };

    public static String getImagesLocation() {
        File path = Environment.getExternalStoragePublicDirectory(
            Environment.DIRECTORY_PICTURES);
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "/MaryJaneResult_" + timeStamp + "_";
        return path.getAbsolutePath() + imageFileName;
    }

    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "MaryJane_" + timeStamp + "_";
        File path = Environment.getExternalStoragePublicDirectory(
            Environment.DIRECTORY_PICTURES);
        File image = File.createTempFile(
            imageFileName,  /* prefix */
            ".jpeg",         /* suffix */
            path      /* directory */
        );

        // Save a file: path for use with ACTION_VIEW intents
        mCurrentPhotoPath = image.getAbsolutePath();


        // Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
        // File f = new File(mCurrentPhotoPath);
        // Uri contentUri = Uri.fromFile(f);
        // mediaScanIntent.setData(contentUri);
        // this.sendBroadcast(mediaScanIntent);

        return image;
    }

    public AndroidUtils()
    {
        m_instance = this;

        //mediaScannerConnection = new MediaScannerConnection(getApplicationContext(), mediaScannerConnectionClient);
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onDestroy()
    {
        super.onDestroy();
    }

    static void updateGallery(String path) {
        m_instance.doUpdateGallery(path);
    }

    static void openAnImage()
    {
        m_instance.dispatchOpenGallery();
    }

    static void shareImage(String path)
    {
        m_instance.doShareImage(path);
    }

    static void openCamera() {
        m_instance.doOpenCamera();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        if(requestCode == PICK_PHOTO_CODE/*REQUEST_OPEN_IMAGE*/) {
            if (resultCode == RESULT_OK) {

                String filePath = getRealPathFromURI(getApplicationContext(), data.getData());
                fileSelected(filePath);
            } else {
                fileSelected(":(");
            }
        } else if (requestCode == REQUEST_TAKE_PHOTO) {
            if (resultCode == RESULT_OK) {
                //Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), mCurrentPhotoPath);
                // Bundle extras = data.getExtras();
                // Bitmap imageBitmap = (Bitmap) extras.get("data");

                Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
                File f = new File(mCurrentPhotoPath);
                Uri contentUri = Uri.fromFile(f);

                changeOrientation(contentUri);
                
                //mediaScannerConnection.connect();

                //photoTaken(mCurrentPhotoPath);

                MediaScannerConnection.scanFile(this,
                        new String[] { mCurrentPhotoPath.toString() }, null,
                        new MediaScannerConnection.OnScanCompletedListener() {
                    public void onScanCompleted(String path, Uri uri) {
                        Log.i("ExternalStorage", "Scanned " + path + ":");
                        Log.i("ExternalStorage", "-> uri=" + uri);
                        photoTaken(mCurrentPhotoPath);
                    }
                });
            }
        }

        super.onActivityResult(requestCode, resultCode, data);
    }

    private void doUpdateGallery(String fileName) {
        MediaScannerConnection.scanFile(this,
                new String[] { fileName.toString() }, null,
                new MediaScannerConnection.OnScanCompletedListener() {
            public void onScanCompleted(String path, Uri uri) {
                Log.i("ExternalStorage", "Scanned " + path + ":");
                Log.i("ExternalStorage", "-> uri=" + uri);
                galleryUpdated(path);
            }
        });
    }

    private void dispatchOpenGallery()
    {
        // Create intent for picking a photo from the gallery
        Intent intent = new Intent(Intent.ACTION_PICK,
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        // If you call startActivityForResult() using an intent that no app can handle, your app will crash.
        // So as long as the result is not null, it's safe to use the intent.
        if (intent.resolveActivity(getPackageManager()) != null) {
           // Bring up gallery to select a photo
           startActivityForResult(intent, PICK_PHOTO_CODE);
        }





//        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
//        intent.setType("image/*");
//        startActivityForResult(intent, REQUEST_OPEN_IMAGE);
    }

    public void doShareImage(String filePath) {

      if (QtNative.activity() == null) {
        Log.d("MAINACTIVITY", "error in share text!");
      }

      File file = new File(filePath);

      Intent shareIntent = new Intent();
      shareIntent.setAction(Intent.ACTION_SEND);
      shareIntent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(file));
      shareIntent.setType("image/png");

      /*QtNative.activity().*/startActivity(Intent.createChooser(shareIntent, "Share"));
    }

    void doOpenCamera()
    {
    //    Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
    //    if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
    //        startActivityForResult(takePictureIntent, REQUEST_TAKE_PHOTO);
    //    }

        Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        // Ensure that there's a camera activity to handle the intent
        if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
            // Create the File where the photo should go
            File photoFile = null;
            try {
                photoFile = createImageFile();
            } catch (IOException ex) {
                // Error occurred while creating the File
                //...
            }
            // Continue only if the File was successfully created
            if (photoFile != null) {
                Uri photoURI = Uri.fromFile(photoFile);
//                Uri photoURI = FileProvider.getUriForFile(this,
//                                                      "com.example.android.fileprovider",
//                                                      photoFile);
                takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);
                startActivityForResult(takePictureIntent, REQUEST_TAKE_PHOTO);
            }
        }
    }

    public String getRealPathFromURI(Context context, Uri contentUri)
    {
        Cursor cursor = null;
        try
        {
            String[] proj = { MediaStore.Images.Media.DATA };
            cursor = context.getContentResolver().query(contentUri,  proj, null, null, null);
            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            cursor.moveToFirst();
            return cursor.getString(column_index);
        }
        finally
        {
            if (cursor != null)
            {
                cursor.close();
            }
        }
    }

    private int getOrientation() {
        CameraManager manager = (CameraManager) getSystemService(Context.CAMERA_SERVICE);
        int orientation = 0;
        try {
            String cameraId = manager.getCameraIdList()[0];
            CameraCharacteristics characteristics = manager.getCameraCharacteristics(cameraId);
            orientation = characteristics.get(CameraCharacteristics.SENSOR_ORIENTATION);
        }
        catch (Exception e)
        {}

        return orientation;
    }

    private static Bitmap rotateImage(Bitmap img, int degree) {
        Matrix matrix = new Matrix();
        matrix.postRotate(degree);
        Bitmap rotatedImg = Bitmap.createBitmap(img, 0, 0, img.getWidth(), img.getHeight(), matrix, true);
        img.recycle();
        return rotatedImg;
    }

    private static Bitmap rotateImageIfRequired(Context context, Bitmap img, Uri selectedImage) throws IOException {

        //InputStream input = context.getContentResolver().openInputStream(selectedImage);
        ExifInterface ei;
        // if (Build.VERSION.SDK_INT > 23)
        //     ei = new ExifInterface(input);
        // else
            ei = new ExifInterface(selectedImage.getPath());

        int orientation = ei.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);

        switch (orientation) {
            case ExifInterface.ORIENTATION_ROTATE_90:
                return rotateImage(img, 90);
            case ExifInterface.ORIENTATION_ROTATE_180:
                return rotateImage(img, 180);
            case ExifInterface.ORIENTATION_ROTATE_270:
                return rotateImage(img, 270);
            default:
                return img;
        }
    }

    private void changeOrientation(Uri selectedImage) {

        int orientation = getOrientation();
        int rotation = ExifInterface.ORIENTATION_NORMAL;
        Log.d("HUEG","orientation = " + orientation);

        switch (orientation) {
            case 90:
                rotation = ExifInterface.ORIENTATION_ROTATE_90;
                break;
            case 180:
                rotation = ExifInterface.ORIENTATION_ROTATE_180;
                break;
            case 270:
                rotation = ExifInterface.ORIENTATION_ROTATE_270;
                break;
            default:
                break;
        }

        try {
        //InputStream input = context.getContentResolver().openInputStream(selectedImage);
        ExifInterface ei;
        // if (Build.VERSION.SDK_INT > 23)
        //     ei = new ExifInterface(input);
        // else
            ei = new ExifInterface(selectedImage.getPath());

        ei.setAttribute(ExifInterface.TAG_ORIENTATION, String.valueOf(rotation));
        
            ei.saveAttributes();
        }
        catch (Exception e)
        {}
    }

}

