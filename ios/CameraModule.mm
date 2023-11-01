#ifdef RCT_NEW_ARCH_ENABLED
#import "CameraModule.h"
#import "VisionCamera-Swift.h"

static CameraView* cameraView;

@implementation CameraModule

RCT_EXPORT_MODULE()

+(void) setCurrentCamera:(UIView*)view{
    cameraView = (CameraView*) view;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeCameraModuleSpecJSI>(params);
}

- (void)focus:(JS::NativeCameraModule::SpecFocusPoint &)point resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        NSDictionary* dictionary = @{@"x": [NSNumber numberWithDouble:point.x()], @"y": [NSNumber numberWithDouble:point.y()]};
        [CameraViewManager focusWithPoint:dictionary  resolve:resolve reject:reject view:cameraView];
    }
}

- (void)getAvailableVideoCodecs:(NSString *)fileType resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        [CameraViewManager getAvailableVideoCodecsWithFileType:fileType resolve:resolve reject:reject view:cameraView];
    }
}

- (void)getMicrophonePermissionStatus:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [CameraViewManager getMicrophonePermissionStatus:resolve reject:reject];
}

- (void)pauseRecording:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        [CameraViewManager pauseRecordingWithResolve:resolve reject:reject view:cameraView];
    }
}

- (void)requestCameraPermission:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [CameraViewManager requestCameraPermission:resolve reject:reject];
}

- (void)requestMicrophonePermission:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [CameraViewManager requestMicrophonePermission:resolve reject:reject];
}

- (void)resumeRecording:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        [CameraViewManager resumeRecordingWithResolve:resolve reject:reject view:cameraView];
    }
}

- (void)startRecording:(JS::NativeCameraModule::SpecStartRecordingOptions &)options onRecordCallback:(RCTResponseSenderBlock)onRecordCallback {
    if(cameraView != nil){
        NSMutableDictionary* optionsDict = [[NSMutableDictionary alloc] init]; // TODO: Convert struct to dictionary in a better way
        if(options.fileType()){
            [optionsDict setObject:options.fileType() forKey:@"fileType"];
        }
        if(options.flash()){
            [optionsDict setObject:options.flash() forKey:@"flash"];
        }
        if(options.videoCodec()){
            [optionsDict setObject:options.videoCodec() forKey:@"videoCodec"];
        }
        [CameraViewManager startRecordingWithOptions:optionsDict onRecordCallback:onRecordCallback view:cameraView];
    }
}

- (void)stopRecording:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        [CameraViewManager stopRecordingWithResolve:resolve reject:reject view:cameraView];
    }
}

- (void)takePhoto:(JS::NativeCameraModule::SpecTakePhotoOptions &)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if(cameraView != nil){
        NSNumber* enableAutoRedEyeReduction = options.enableAutoRedEyeReduction() ? @1 : @0; // TODO: find better way to convert optional<bool> to some objc object
        NSNumber* enableAutoStabilization = options.enableAutoStabilization() ? @1 : @0;
        NSNumber* enableAutoDistortionCorrection = options.enableAutoDistortionCorrection() ? @1 : @0;
        NSNumber* skipMetadata = options.skipMetadata() ? @1 : @0;
        
        NSMutableDictionary* optionsDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"enableAutoRedEyeReduction":enableAutoRedEyeReduction,@"enableAutoStabilization":enableAutoStabilization,@"enableAutoDistortionCorrection":enableAutoDistortionCorrection,@"skipMetadata":skipMetadata}]; // TODO: Convert struct to dictionary in a better way
        
        if(options.flash()){
            [optionsDict setObject:options.flash() forKey:@"flash"];
        }
        if(options.qualityPrioritization()){
            [optionsDict setObject:options.qualityPrioritization() forKey:@"qualityPrioritization"];
        }
        
        [CameraViewManager takePhotoWithOptions:optionsDict resolve:resolve reject:reject view:cameraView];
    }
}

- (void)takeSnapshot:(JS::NativeCameraModule::SpecTakeSnapshotOptions &)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    // DO NOTHING
}

- (void)getCameraPermissionStatus:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [CameraViewManager getCameraPermissionStatus:resolve reject:reject];
}

- (void)getAvailableCameraDevices:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    [CameraViewManager getAvailableCameraDevices:resolve reject:reject];
}

@end
#endif
