//
// Copyright 2014 Regan Sarwas, National Park Service  - regan_sarwas@nps.gov
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import <Foundation/Foundation.h>
#import "QEntryElement.h"

/*
 QIntegerElement: very much like an entry field, but allows only integral numbers to be typed. TableView control provides a UIStepper.
 */

@interface QIntegerElement : QEntryElement {

}

@property(nonatomic, retain) NSNumber * numberValue;
@property(nonatomic, assign) NSInteger minimumValue;
@property(nonatomic, assign) NSInteger maximumValue;

- (QIntegerElement *)initWithTitle:(NSString *)string value:(NSNumber *)value;
- (QIntegerElement *)initWithValue:(NSNumber *)value;

@end
