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

#import "QEntryTableViewCell.h"
#import "QIntegerTableViewCell.h"
#import "QIntegerElement.h"

@implementation QIntegerElement

@synthesize numberValue = _numberValue;

- (QIntegerElement *)initWithTitle:(NSString *)title value:(NSNumber *)value {
    self = [super initWithTitle:title Value:nil];
    if (self) {
        _numberValue = value;
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return self;
}

- (void)setFloatValue:(NSNumber *)floatValue {
    _numberValue = floatValue;
    if (_numberValue==nil)
        _numberValue = @0;
}

- (QIntegerElement *)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        _numberValue = value;
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return self;
}

- (QIntegerElement *)init {
    self = [super init];
    if (self) {
        _numberValue = @0;
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }

    return self;
}


- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {

    QIntegerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickformIntegerElement"];
    if (cell==nil){
        cell = [[QIntegerTableViewCell alloc] init];
    }
    [cell prepareForElement:self inTableView:tableView];
    cell.textField.userInteractionEnabled = self.enabled;

    return cell;
}

- (void)fetchValueIntoObject:(id)obj {
	if (_key==nil)
		return;
    [obj setValue:_numberValue forKey:_key];
}

@end
