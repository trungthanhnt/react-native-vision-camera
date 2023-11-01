//
//  CameraBridge.h
//  mrousavy
//
//  Created by Marc Rousavy on 09.11.20.
//  Copyright © 2020 mrousavy. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>

#import "RCTBridge+runOnJS.h"
#import "JSConsoleHelper.h"

static bool VISION_CAMERA_ENABLE_FRAME_PROCESSORS = false;

@interface CameraBridge: RCTViewManager

@end
