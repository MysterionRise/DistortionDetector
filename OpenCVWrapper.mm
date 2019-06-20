//
//  OpenCVWrapper.m
//  DistortionDetector
//
//  Created by Konstantin on 13/04/2019.
//  Copyright © 2019 Konstantin. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

+ (UIImage *)toGray:(UIImage *)source {
    cv::Mat img;
    cv::Mat result;
    UIImageToMat(source, img);
    cvtColor(img, result, CV_BGR2GRAY);
    return MatToUIImage(result);
}

+ (UIImage *)containsChessBoard:(NSArray *)input {
    cv::Size patternsize(9, 6); //interior number of corners TODO make it param
    std::vector<cv::Point2f> imageCorners; //this will be filled by the detected corners
    std::vector<cv::Point3f> objectCorners;
    
    std::vector<std::vector<cv::Point2f>> imageObjects;
    std::vector<std::vector<cv::Point3f>> objectObjects;
    
    for (int i = 0; i < 9; ++i)
        for (int j = 0; j < 6; ++j)
            objectCorners.push_back(cv::Point3f(i, j, 0.0f));
    
    cv::Size imgSize;
    std::vector<cv::Mat> result;
    
    int count = input.count;
    for (int i = 0; i < count; ++i) {
        cv::Mat img;
        cv::Mat gray;
        UIImageToMat(input[i], img);
        imgSize = img.size();
        cvtColor(img, gray, CV_BGR2GRAY);
        bool patternfound = findChessboardCorners(gray, patternsize, imageCorners,
                                                  cv::CALIB_CB_ADAPTIVE_THRESH + cv::CALIB_CB_NORMALIZE_IMAGE
                                                  + cv::CALIB_CB_FAST_CHECK);
        if(patternfound) {
            cornerSubPix(gray, imageCorners, cv::Size(11, 11), cv::Size(-1, -1),
                         cvTermCriteria(CV_TERMCRIT_EPS + CV_TERMCRIT_ITER, 30, 0.1));
//        drawChessboardCorners(img, patternsize, cv::Mat(imageCorners), patternfound);
        
//        result.push_back(img);
            imageObjects.push_back(imageCorners);
            objectObjects.push_back(objectCorners);
        }
    }
    
    cv::Mat cameraMatrix;
    cv::Mat distCoeffs;
    std::vector<cv::Mat> rvecs, tvecs;
    
    NSLog(@"Running calibrate camera");
    double error = cv::calibrateCamera(objectObjects, imageObjects, imgSize, cameraMatrix, distCoeffs, rvecs, tvecs);
    
    NSLog(@"Debug");
    for (int i = 0; i < distCoeffs.size().height; ++i)
        for (int j = 0; j < distCoeffs.size().width; ++j)
            NSLog(@"%f", distCoeffs.at<float>(i, j));
    
    cv::Mat optimalMatrix = cv::getOptimalNewCameraMatrix(cameraMatrix, distCoeffs, imgSize, 1.0f);
    
    cv::Mat freshInput;
    cv::Mat newRes;
    UIImageToMat(input[0], freshInput);
    
    cv::undistort(freshInput, newRes, cameraMatrix, distCoeffs, optimalMatrix);
    return MatToUIImage(newRes);
}

@end
