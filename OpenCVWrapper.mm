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
    //    TODO fix and ACTUALLY convery to gray color :)
//    return source;
}

@end
