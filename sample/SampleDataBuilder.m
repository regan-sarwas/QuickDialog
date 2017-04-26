//                                
// Copyright 2011 ESCOZ Inc  - http://escoz.com
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

#import <objc/runtime.h>
#import "SampleDataBuilder.h"
#import "QDynamicDataSection.h"
#import "PeriodPickerValueParser.h"
#import "QMapElement.h"
#import "QWebElement.h"
#import "QMailElement.h"
#import "QPickerElement.h"

@implementation SampleDataBuilder

+ (QRootElement *)createWithInitDefault {

    QRootElement *subForm = [[QRootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Default Initialization";
	subForm.controllerName = @"ExampleViewController";
    QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[QLabelElement alloc] init]];
	[subsection	addElement:[[QBadgeElement alloc] init]];
	[subsection	addElement:[[QBooleanElement alloc] init]];
	[subsection	addElement:[[QButtonElement alloc] init]];
	[subsection	addElement:[[QDateTimeInlineElement alloc] init]];
	[subsection	addElement:[[QFloatElement alloc] initWithValue:0.33]];
	[subsection	addElement:[[QMapElement alloc] init]];
    [subsection	addElement:[[QPickerElement alloc] init]];
	[subsection	addElement:[[QRadioElement alloc] init]];
	[subsection	addElement:[[QRadioItemElement alloc] init]];
	[subsection	addElement:[[QTextElement alloc] init]];
	[subsection	addElement:[[QWebElement alloc] init]];
	
	return subForm;
}


+ (QRootElement *)createWithInitAndKey {
	
    QRootElement *subForm = [[QRootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Initialization With Key";
    subForm.controllerName = @"ExampleViewController";
	QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    [subForm addSection:subsection];
	
	[subsection addElement:[[QLabelElement alloc] initWithKey:@"Key1"]];
    [subsection addElement:[[QMultilineElement alloc] initWithKey:@"Key3"]];
	[subsection	addElement:[[QBadgeElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QBooleanElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QButtonElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QDateTimeInlineElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QFloatElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QMapElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QRadioElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QRadioItemElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QTextElement alloc] initWithKey:@"Key1"]];
	[subsection	addElement:[[QWebElement alloc] initWithKey:@"Key1"]];
	
	return subForm;
}

+ (QElement *)reallyLongList {
    QRootElement *subForm = [[QRootElement alloc] init];
    subForm.grouped = YES;
    subForm.title = @"Really long list";
    subForm.controllerName = @"ExampleViewController";
    QSection *subsection = [[QSection alloc] initWithTitle:@"Long title for the long list of elements"];
    for (int i = 0; i<1000; i++){
        QBooleanElement *bool1 = [[QBooleanElement alloc] initWithTitle:[NSString stringWithFormat:@"Option %d", i] BoolValue:(i % 3 == 0)];
        bool1.onImage = [UIImage imageNamed:@"imgOn"];
        bool1.offImage = [UIImage imageNamed:@"imgOff"];
        bool1.onValueChanged = ^(QRootElement *el){
            NSLog(@"Bool selected! ");
        };
        [subsection addElement:bool1];
    }
    [subForm addSection:subsection];
    return subForm;
}

+ (QRootElement *)createSampleFormRoot {
    QRootElement *subForm = [[QRootElement alloc] init];
    QSection *subsection = [[QSection alloc] initWithTitle:@"SubSection"];
    subForm.grouped = YES;
    subForm.title = @"Subform";
    subForm.controllerName = @"ExampleViewController";

    [subsection addElement:[[QLabelElement alloc] initWithTitle:@"Some title" Value:@"Some value"]];
    QEntryElement *elementEntry = [[QEntryElement alloc] initWithTitle:@"Entry" Value:nil Placeholder:@"type here"];
    elementEntry.key = @"entryElement";
    [subsection addElement:elementEntry];
    [subsection addElement:[[QBooleanElement alloc] initWithTitle:@"boolean" BoolValue:YES]];
    [subsection addElement:[[QEntryElement alloc] initWithTitle:@"Entry 2" Value:@"Some value" Placeholder:@"type here two"]];
    [subForm addSection:subsection];

    QSection *subsection2 = [[QSection alloc] init];
    QButtonElement *myButton = [[QButtonElement alloc] initWithTitle:@"Change Entry"];
    myButton.controllerAction = @"handleChangeEntryExample:";
    [subsection2 addElement:myButton];
    [subForm addSection:subsection2];

    QSection *subsection3 = [[QSection alloc] init];
    QBooleanElement *bool1 = [[QBooleanElement alloc] initWithTitle:@"First option" BoolValue:YES];
    bool1.onImage = [UIImage imageNamed:@"imgOn"];
    bool1.offImage = [UIImage imageNamed:@"imgOff"];
    [subsection3 addElement:bool1];
    [subsection3 addElement:[[QFloatElement alloc] initWithValue:0.5]];
    QBooleanElement *bool2 = [[QBooleanElement alloc] initWithTitle:@"Second option" BoolValue:NO];
    bool2.onImage = [UIImage imageNamed:@"imgOn"];
    bool2.offImage = [UIImage imageNamed:@"imgOff"];
    bool2.controllerAction = @"exampleAction:";
    [subsection3 addElement:bool2];

    QTextElement *element2 = [[QTextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];
    QSection *subsection4 = [[QSection alloc] init];
    [subsection4 addElement:element2];


    [subForm addSection:subsection3];
    [subForm addSection:subsection4];
    return subForm;
}

+ (QRootElement *)createSlidersRoot {
    QRootElement *sliders = [[QRootElement alloc] init];
    sliders.grouped = YES;
    sliders.title = @"Sliders";
    sliders.controllerName = @"ExampleViewController";
    QSection *detailsSection = [[QSection alloc] initWithTitle:@"Slide left and right"];

    [sliders addSection:detailsSection];

    [detailsSection addElement:[[QFloatElement alloc] initWithValue:0.5]];
    [detailsSection addElement:[[QFloatElement alloc] initWithTitle:@"Short" value:0.7]];
    [detailsSection addElement:[[QFloatElement alloc] initWithTitle:@"Really really long title" value:1]];

    return sliders;
}

+ (QElement *)createSampleControls {
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    root.title = @"Sample Controls";
    root.controllerName = @"ExampleViewController";
    QSection *controls = [[QSection alloc] initWithTitle:@"Change something"];

    QLabelElement *element1 = [[QLabelElement alloc] initWithTitle:@"Label" Value:@"element"];


    QRadioElement *radioElement = [[QRadioElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"Option 1", @"Option 2", @"Option 3",@"Option 11", @"Option 12", @"Option 13", @"Option 21", @"Option 22", @"Option 33", @"Option 41", @"Option 42", @"Option 43", @"Option 51", @"Option 52", @"Option 53", @"Option 61", @"Option 62", @"Option 63", @"Option 71", @"Option 72", @"Option 73", nil] selected:7 title:@"Radio"];
    radioElement.itemsImageNames = @[ @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel", @"iPhone", @"intel" ];
	radioElement.key = @"radio1";



    QBooleanElement *boolElement = [[QBooleanElement alloc] initWithTitle:@"Boolean Element" BoolValue:YES];
    boolElement.controllerAction = @"exampleAction:";
	boolElement.key = @"bool1";
	
    QEntryElement *entryElement = [[QEntryElement alloc] initWithTitle:@"Entry Element" Value:nil Placeholder:@"type here"];
	entryElement.key = @"entry1";

    NSArray *values = [NSArray arrayWithObjects:@"Ferrari", @"Ms.",@"Mrs.",@"Miss",@"Mr.",@"Prof.",@"A/Prof.",nil];
    QAutoEntryElement *autoElement = [[QAutoEntryElement alloc] initWithTitle:@"AutoComplete" value:nil placeholder:@"type letter M"];
    autoElement.autoCompleteValues = values;
    autoElement.autoCompleteColor = [UIColor orangeColor];
	autoElement.key = @"entry2";

    controls.footer = @"More controls will be added.";
    [controls addElement:element1];

    [controls addElement:radioElement];
    [controls addElement:entryElement];
    [controls addElement:autoElement];
	
    [controls addElement:boolElement];
	QDateTimeInlineElement *dateElement = [[QDateTimeInlineElement alloc] initWithTitle:@"DateTime" date:[NSDate date] andMode:UIDatePickerModeDateAndTime];
	dateElement.key = @"date1";
    [controls addElement:dateElement];

    QFloatElement *slider = [[QFloatElement alloc] initWithTitle:@"Float Element" value:0.5];
	slider.key = @"slider1";
    [controls addElement:slider];
    
    QDecimalElement *decimal = [[QDecimalElement alloc] initWithTitle:@"Decimal Element" value:@0.5];
    decimal.key = @"decimal1";
    decimal.fractionDigits = 2;
    [controls addElement:decimal];

    QIntegerElement *integral = [[QIntegerElement alloc] initWithTitle:@"Integer Element" value:@3];
    integral.key = @"integer1";
    //default integral.minimumValue is 0; integral.maximumValue is 100
    integral.maximumValue = 10;
    [controls addElement:integral];

    QIntegerElement *integral2 = [[QIntegerElement alloc] initWithTitle:@"Null Integer" value:nil];
    integral2.key = @"integer2";
    //default integral.minimumValue is 0; integral.maximumValue is 100
    integral2.minimumValue = -10;
    integral2.maximumValue = 123;
    [controls addElement:integral2];

    QMultilineElement *multiline = [[QMultilineElement alloc] initWithTitle:@"Multiline" value:@""];
    multiline.key = @"multiline";
    [controls addElement:multiline];
    
    QLabelElement *element2 = [[QLabelElement alloc] initWithTitle:@"Label Different Height" Value:@"70"];
    element2.height = 70;
    [controls addElement:element2];
    
    [controls addElement:[QLoadingElement new]];
    
    QProgressElement *progressElement = [QProgressElement new];
    progressElement.progress = 0.24601;
    [controls addElement:progressElement];

    QSection *btnSection = [[QSection alloc] init];
	QButtonElement *button = [[QButtonElement alloc] initWithTitle:@"Show form values"];
	button.onSelected = ^{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:[NSString stringWithFormat:@"1: %ld\n2: %@\n3: %d\n4:%@\n5:%f\n6:%@\n7:%@\n8:%@",
                (long)radioElement.selected ,
                entryElement.textValue,
                boolElement.boolValue,
                dateElement.dateValue ,
                slider.floatValue,
                decimal.numberValue,
                integral.numberValue,
                                    autoElement.textValue]
           delegate:self 
           cancelButtonTitle:@"OK" 
           otherButtonTitles:nil];
		[alert show];

	};
    [btnSection addElement:button];

    QSection *btnSection2 = [[QSection alloc] init];
	QButtonElement *button2 = [[QButtonElement alloc] initWithTitle:@"Fetch into dictionary"];
	button2.onSelected = ^{
		
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [root fetchValueIntoObject:dict];
		
        NSString *msg = @"Values:";
		for (NSString *aKey in dict){
            msg = [msg stringByAppendingFormat:@"\n- %@: %@", aKey, [dict valueForKey:aKey]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	};
    [btnSection2 addElement:button2];
    btnSection2.footer = @"Here's a really long footer text that could be used to make your users happy!";

    QSection *segmented = [[QSection alloc] initWithTitle:@"Here's a long title for this segmented control"];
    segmented.footer = @"And heres a long footer text for this segmented control";

    QSegmentedElement *segmentedElement = [[QSegmentedElement alloc] initWithItems:[[NSArray alloc] initWithObjects:@"Option 1", @"Option 2", @"Option 3", nil] selected:0 title:@"Radio"];
    radioElement.key = @"segmented1";
    [segmented addElement:segmentedElement];

    [root addSection:controls];
    [root addSection:segmented];
    [root addSection:btnSection];
    [root addSection:btnSection2];
    
    for (QSection *section in root.sections) {
        for (QElement *e in section.elements) {
            if ([e isKindOfClass:[QEntryElement class]]) {
                ((QEntryElement *)e).onValueChanged = ^(QRootElement *el){
                    NSLog(@"Value changed: %@", el);
                };
            }
        }
    }
    return root;
}

+ (void)QEntryEditingChangedForElement:(QEntryElement *)element andCell:(QEntryTableViewCell *)cell {
    NSLog(@"Editing changed");
}


+ (QElement *)createRadioRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Radio";
    root.grouped = YES;

    QSection *section1 = [[QSection alloc] initWithTitle:@"Radio element with push"];
    [section1 addElement:[[QRadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0]];
    [section1 addElement:[[QRadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"]];
    [section1 addElement:[[QRadioElement alloc] initWithDict:[NSDictionary dictionaryWithObjectsAndKeys:@"FerrariObj", @"Ferrari", @"McLarenObj", @"McLaren", @"MercedesObj", @"Mercedes", nil] selected:0 title:@"With Dict"]];

    QRadioElement *elementWithAction = [[QRadioElement alloc] initWithItems:[NSArray arrayWithObjects:@"Ferrari", @"McLaren", @"Lotus", nil] selected:0 title:@"WithAction"];
    elementWithAction.controllerAction = @"exampleAction:";
    [section1 addElement:elementWithAction];
    [root addSection:section1];

    QRadioSection *section2 = [[QRadioSection alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil] selected:0 title:@"Sport"];
    __weak QRadioSection *_section2 = section2;
    section2.onSelected = ^{ NSLog(@"selected index: %ld", (long)_section2.selected); };
    [root addSection:section2];

    return root;
}

+ (QElement *)createPickerRoot
{
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Picker";
    root.grouped = YES;

    NSArray *component1 = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    NSArray *component2 = @[@"A", @"B"];
    QPickerElement *simplePickerEl = [[QPickerElement alloc] initWithTitle:@"Key" items:@[component1, component2] value:@"3\tB"];
    
    __weak QPickerElement *_simplePickerEl = simplePickerEl;

    simplePickerEl.onValueChanged = ^(QRootElement *el){
        NSLog(@"Selected indexes: %@", [_simplePickerEl.selectedIndexes componentsJoinedByString:@","]);
    };

    QSection *simplePickerSection = [[QSection alloc] initWithTitle:@"Picker element"];
    [simplePickerSection addElement:simplePickerEl];
    [root addSection:simplePickerSection];
    
    QSection *customParserSection = [[QSection alloc] initWithTitle:@"Custom value parser"];
    
    PeriodPickerValueParser *periodParser = [[PeriodPickerValueParser alloc] init];
    
    QPickerElement *periodPickerEl =
        [[QPickerElement alloc] initWithTitle:@"Period"
                                        items:[NSArray arrayWithObject:periodParser.stringPeriods]
                                        value:[NSNumber numberWithUnsignedInteger:NSMonthCalendarUnit]];
    
    periodPickerEl.valueParser = periodParser;
    __weak QPickerElement *_periodPickerEl = periodPickerEl;
    periodPickerEl.onValueChanged = ^(QRootElement *el){ NSLog(@"New value: %@", _periodPickerEl.value); };
    
    [customParserSection addElement:periodPickerEl];
    [root addSection:customParserSection];
    
    return root;
}

+ (QElement *)createSelectRoot
{
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Select";
    root.grouped = YES;
    
    QSelectSection *simpleSelectSection =
        [[QSelectSection alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil]
                              selectedIndexes:nil title:@"Simple select"];
    
    QSelectSection *multipleSelectSection =
        [[QSelectSection alloc] initWithItems:[NSArray arrayWithObjects:@"Football", @"Soccer", @"Formula 1", nil]
                              selectedIndexes:[NSArray arrayWithObjects:
                                               [NSNumber numberWithUnsignedInteger:0],
                                               [NSNumber numberWithUnsignedInteger:1], nil]
                                        title:@"Multiple select"];
    multipleSelectSection.multipleAllowed = YES;
    
    [root addSection:simpleSelectSection];
    [root addSection:multipleSelectSection];
    
    return root;
}

+ (QRootElement *)createMailRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.title = @"Mail";
    
    QMailElement *element1 = [[QMailElement alloc] initWithTitle:@"Contact escoz" subject:@"Hello Escoz" messageBody:@"Dear Escoz" toRecipients:@[@"contact@escoz.com"] ccRecipients:nil bccRecipients:nil];
    QMailElement *element2 = [[QMailElement alloc] initWithTitle:@"Contact flyerhzm" subject:@"Hello Richard" messageBody:@"Dear Richard" toRecipients:@[@"flyerhzm@gmail.com"] ccRecipients:nil bccRecipients:nil];
    
    QSection *section = [[QSection alloc] init];
    [section addElement:element1];
    [section addElement:element2];
    
    [root addSection:section];
    return root;
}

+ (QRootElement *)createWebAndMapRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Web and map";

    QWebElement *element1 = [[QWebElement alloc] initWithTitle:@"ESCOZ Inc" url:@"http://escoz.com"];
    element1.controllerAction = @"handleWebElementControllerAction:";
    QWebElement *element2 = [[QWebElement alloc] initWithTitle:@"Quicklytics" url:@"http://escoz.com/quicklytics"];
    QMapElement *element4 = [[QMapElement alloc] initWithTitle:@"Florianopolis, Brazil" coordinate:CLLocationCoordinate2DMake(-27.59, -48.55)];

    QSection *section1 = [[QSection alloc] init];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [section1 addElement:element4];

    [root addSection:section1];
    return root;
}

+ (QRootElement *)createTextRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Text";

    QTextElement *element1 = [[QTextElement alloc] initWithText:
            @"Preparing for her flight\n"
            "I held with all my might\n"
            "Fearing my deepest fright\n"
            "She walked into the night\n"
            "She turned for one last look\n"
            "She looked me in the eye\n"
            "I said, \"I Love You...\n"
            "Good-bye\""];

    QTextElement *element2 = [[QTextElement alloc] initWithText:@"You get all kinds of notifications on your iOS device: new email, texts, friend requests, and more. With Notification Center, you can keep track of them all in one convenient location. Just swipe down from the top of any screen to enter Notification Center. Choose which notifications you want to see. Even see a stock ticker and the current weather. New notifications appear briefly at the top of your screen, without interrupting what you’re doing. And the Lock screen displays notifications so you can act on them with just a swipe. Notification Center is the best way to stay on top of your life’s breaking news."];

    QTextElement *element3 = [[QTextElement alloc] initWithText:@"Quicklytics App!"];
    element3.color = [UIColor blueColor];

    QSection *section1 = [[QSection alloc] init];
    [section1 addElement:element3];
    [section1 addElement:element1];
    [section1 addElement:element2];
    [root addSection:section1];
    return root;
}

+ (QRootElement *)createLabelsRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Labels";
    root.grouped = YES;
    QSection *s1 = [[QSection alloc] initWithTitle:@"LabelElement"];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"With no value" Value:nil]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"With a value" Value:@"Value"]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"Or a simple number" Value:@"123"]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"Long text long text long text long text" Value:@"this is the value"]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:@"Long text and no value - long text long text long text" Value:nil]];
    [s1 addElement:[[QLabelElement alloc] initWithTitle:nil Value:@"Long value and no title - long text long text long text"]];

    QSection *s2 = [[QSection alloc] initWithTitle:@"BadgeElement"];
    QBadgeElement *badge1 = [[QBadgeElement alloc] initWithTitle:@"With a badge" Value:@"1"];
    [s2 addElement:badge1];
    QBadgeElement *badge2 = [[QBadgeElement alloc] initWithTitle:@"With a pink badge" Value:@"123"];
    badge2.badgeColor = [UIColor colorWithRed:0.9518 green:0.3862 blue:0.4113 alpha:1.0000];
    [s2 addElement:badge2];

    QSection *secImg = [[QSection alloc] initWithTitle:@"Images"];
    QLabelElement *b1 = [[QLabelElement alloc] initWithTitle:@"Processor" Value:@"OK"];
    b1.image = [UIImage imageNamed:@"intel"];
    [secImg addElement:b1];

    QLabelElement *b4 = [[QLabelElement alloc] initWithTitle:@"Processor processor processor processor processor processor processor" Value:nil];
    b4.image = [UIImage imageNamed:@"intel"];
    [secImg addElement:b4];

    QLabelElement *b2 = [[QLabelElement alloc] initWithTitle:@"iPhone" Value:@"OK"];
    b2.image = [UIImage imageNamed:@"iPhone"];
    [secImg addElement:b2];

    QBadgeElement *b3 = [[QBadgeElement alloc] initWithTitle:@"Keyboard" Value:@"ERROR"];
    b3.image = [UIImage imageNamed:@"keyboard"];
    b3.badgeColor = [UIColor redColor];
    [secImg addElement:b3];

    QBadgeElement *badge3 = [[QBadgeElement alloc] initWithTitle:@"With some action" Value:@"123"];
    badge3.badgeColor = [UIColor purpleColor];
    QSection *sec = [[QSection alloc] initWithTitle:@"Jazzin.."];
    [badge3 addSection:sec];

    QBadgeElement *b5 = [[QBadgeElement alloc] initWithTitle:@"With a really really really long title" Value:@"YEAH"];
    [s2 addElement:b5];

    [s2 addElement:badge3];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test" Value:@"0"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 2" Value:@"10"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 3" Value:@"200"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 4" Value:@"1000"]];
    [sec addElement:[[QBadgeElement alloc] initWithTitle:@"Test 5" Value:@"TEST"]];
    
    QSection *s3 = [[QSection alloc] initWithTitle:@"Labeling policies"];
    
    QLabelElement *trimTitleEl = [[QLabelElement alloc] initWithTitle:@"QLabelingPolicyTrimTitle" Value:@"really really really long value"];
    trimTitleEl.labelingPolicy = QLabelingPolicyTrimTitle;  // this is default
    trimTitleEl.height = 80;
    [s3 addElement:trimTitleEl];
    
    QLabelElement *trimValueEl = [[QLabelElement alloc] initWithTitle:@"QLabelingPolicyTrimValue" Value:@"really really really long value"];
    trimValueEl.labelingPolicy = QLabelingPolicyTrimValue;
    trimValueEl.height = 80;
    [s3 addElement:trimValueEl];

    [root addSection:s1];
    [root addSection:s2];
    [root addSection:s3];
    [root addSection:secImg];



    return root;
}


+ (QRootElement *)createEntryRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Entry";
    root.grouped = YES;
    
    QSection *firstSection = [[QSection alloc] initWithTitle:@"Entry Elements"];
    
    [firstSection addElement:[[QEntryElement alloc] initWithTitle:nil Value:nil Placeholder:@"placeholder"]];
    [firstSection addElement:[[QEntryElement alloc] initWithTitle:@"With Title" Value:nil Placeholder:@"text here"]];
    [firstSection addElement:[[QEntryElement alloc] initWithTitle:@"With Very Long Title" Value:@"" Placeholder:@"text"]];
    
    [root addSection:firstSection];

    QSection *prefixSuffixSection = [[QSection alloc] initWithTitle:@"Prefix/suffix"];
    prefixSuffixSection.footer = @"Prefix/suffix is only displayed, they're not stored in textValue";

    QEntryElement *prefixElement = [[QEntryElement alloc] initWithTitle:nil Value:nil Placeholder:@"with prefix"];
    prefixElement.keyboardType = UIKeyboardTypeNumberPad;
    prefixElement.prefix = @"$";

    QEntryElement *suffixElement = [[QEntryElement alloc] initWithTitle:nil Value:nil Placeholder:@"with suffix"];
    suffixElement.keyboardType = UIKeyboardTypeNumberPad;
    suffixElement.suffix = @" km";

    QEntryElement *prefixSuffixElement = [[QEntryElement alloc] initWithTitle:nil Value:nil Placeholder:@"with prefix and suffix"];
    prefixSuffixElement.prefix = @"* ";
    prefixSuffixElement.suffix = @" *";

    [prefixSuffixSection addElement:prefixElement];
    [prefixSuffixSection addElement:suffixElement];
    [prefixSuffixSection addElement:prefixSuffixElement];
    [root addSection:prefixSuffixSection];
    
    QSection *traitsSection = [[QSection alloc] initWithTitle:@"UITextInputTraits"];
    
    QEntryElement *secureElement = [[QEntryElement alloc] initWithTitle:@"Secure" Value:@"" Placeholder:@"YES"];
    secureElement.secureTextEntry = YES;
    [traitsSection addElement:secureElement];

    QEntryElement *keyboardTypeElement = [[QEntryElement alloc] initWithTitle:@"KB Type" Value:@"" Placeholder:@"NumberPad"];
    keyboardTypeElement.keyboardType = UIKeyboardTypeNumberPad;
    [traitsSection addElement:keyboardTypeElement];
    
    QEntryElement *keyboardAppearanceElement = [[QEntryElement alloc] initWithTitle:@"KB Appearance" Value:@"" Placeholder:@"Alert"];
    keyboardAppearanceElement.keyboardAppearance = UIKeyboardAppearanceAlert;
    [traitsSection addElement:keyboardAppearanceElement];
    
    QEntryElement *correctionElement = [[QEntryElement alloc] initWithTitle:@"Correction" Value:@"" Placeholder:@"No"];
    correctionElement.autocorrectionType = UITextAutocorrectionTypeNo;
    [traitsSection addElement:correctionElement];
    
    QEntryElement *capitalizationElement = [[QEntryElement alloc] initWithTitle:@"Capitalization" Value:@"" Placeholder:@"AllCharacters"];
    capitalizationElement.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [traitsSection addElement:capitalizationElement];
    
    QEntryElement *googleElement = [[QEntryElement alloc] initWithTitle:@"Return Key" Value:@"" Placeholder:@"Google"];
    googleElement.returnKeyType = UIReturnKeyGoogle;
    [traitsSection addElement:googleElement];
    
    QEntryElement *enableReturnElement = [[QEntryElement alloc] initWithTitle:@"Auto Return" Value:@"" Placeholder:@"YES"];
    enableReturnElement.enablesReturnKeyAutomatically = YES;
    [traitsSection addElement:enableReturnElement];

    QSection *multilineSection = [[QSection alloc] initWithTitle:@"Entry Elements"];


    QMultilineElement *multiline = [QMultilineElement new];
    multiline.title = @"Multiline entry";
    [multilineSection addElement:multiline];

    [root addSection:multilineSection];
    [root addSection:traitsSection];

    QSection *imageSection = [[QSection alloc] initWithTitle:@"With images"];
    QEntryElement *regularEntryElementWithImage = [[QEntryElement alloc] initWithTitle:@"Entry with image" Value:@"" Placeholder:@"YES"];
    regularEntryElementWithImage.image = [UIImage imageNamed:@"keyboard"];
    [imageSection addElement:regularEntryElementWithImage];
    QMultilineElement *multilineWithImage = [QMultilineElement new];
    multilineWithImage.title = @"Multiline with image";
    multilineWithImage.image = [UIImage imageNamed:@"iPhone"];
    [imageSection addElement:multilineWithImage];

    [root addSection:imageSection];


    return root;
}


+ (QRootElement *)createSortingRoot {

    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Sorting";
    root.grouped = YES;

    QSortingSection *sortingSection = [[QSortingSection alloc] init];
    sortingSection.key = @"sortedSection";
    sortingSection.canDeleteRows = YES;
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"First" Value:@"1"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Second" Value:@"2"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Third" Value:@"3"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Forth" Value:@"4"]];
    [sortingSection addElement:[[QLabelElement alloc] initWithTitle:@"Fifth" Value:@"5"]];

    int i = 1;
    for (QElement * el in sortingSection.elements){
        el.key = [NSString stringWithFormat:@"item %d", i++];
    }

    [root addSection:sortingSection];

    QSection *action = [[QSection alloc] init];
    QButtonElement *button = [[QButtonElement alloc] initWithTitle:@"Read Order"];
    button.onSelected =  ^{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        [sortingSection fetchValueIntoObject:dict];

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello"
            message:[NSString stringWithFormat:@"Order: %@", dict ]
           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	};

    [action addElement:button];
    [root addSection:action];
    return root;
}

+ (QRootElement *)createDateTimeRoot {
    QRootElement *root = [[QRootElement alloc] init];
    root.controllerName = @"ExampleViewController";
    root.title = @"Date Time";
    root.grouped = YES;

    QSection *section = [[QSection alloc] init];
    section.title = @"Inline editing";

    QDateTimeInlineElement *el2 = [[QDateTimeInlineElement alloc] initWithTitle:@"Today" date:[NSDate date] andMode:UIDatePickerModeDate];
    [section addElement:el2];

    QDateTimeInlineElement *el3 = [[QDateTimeInlineElement alloc] initWithTitle:@"Date only" date:[NSDate date] andMode:UIDatePickerModeDate];
    [section addElement:el3];

    QDateTimeInlineElement *el4 = [[QDateTimeInlineElement alloc] initWithTitle:@"Time only" date:[NSDate date] andMode:UIDatePickerModeTime];
    [section addElement:el4];

    QDateTimeInlineElement *elDiffTime = [[QDateTimeInlineElement alloc] initWithTitle:@"Different date" date:
            [NSDate dateWithTimeIntervalSinceNow:-36000] andMode:UIDatePickerModeDate];
    [section addElement:elDiffTime];
    
    QCountdownElement *countDown = [[QCountdownElement alloc] init];
    countDown.title = @"Countdown";
    countDown.ticksValue = [NSNumber numberWithDouble: 9780.0]; // 2Hr 43Min
    [section addElement:countDown];    

    QSection *section2 = [[QSection alloc] init];
    section2.title = @"Push editing";

    QDateTimeElement *el5 = [[QDateTimeElement alloc] initWithTitle:@"Time only" date:[NSDate date]];
    el5.mode = UIDatePickerModeTime;
    [section2 addElement:el5];

    QDateTimeElement *el6 = [[QDateTimeElement alloc] initWithTitle:@"Date only" date:[NSDate date]];
    el6.mode = UIDatePickerModeDate;
    [section2 addElement:el6];

    QDateTimeElement *el7 = [[QDateTimeElement alloc] initWithTitle:@"Full Date" date:[NSDate date]];
    el7.mode = UIDatePickerModeDateAndTime;
    el7.minuteInterval = 3;
    [section2 addElement:el7];

    [root addSection:section];
    [root addSection:section2];
    return root;
}

+ (QElement *)createDynamicSectionRoot {
    QRootElement *const root = [[QRootElement alloc] init ];
    root.controllerName = @"ExampleViewController";
    root.title = @"Dynamic Data Sections";
    root.grouped = YES;


    QDynamicDataSection *defaultSection = [QDynamicDataSection new];
    defaultSection.title = @"Default: loading";
    defaultSection.emptyMessage = @"This is empty";
    [root addSection: defaultSection];

    QDynamicDataSection *emptySection = [QDynamicDataSection new];
    emptySection.title = @"Empty: elements = empty list";
    emptySection.bind = @"iterate:empty";
    emptySection.emptyMessage = @"This is empty";
    emptySection.elements = [NSMutableArray array];
    [root addSection: emptySection];

    QDynamicDataSection *loadingSection = [QDynamicDataSection new];
    loadingSection.title = @"Loading: elements = nil";
    loadingSection.bind = @"iterate:nil";
    loadingSection.elements = nil;
    [root addSection: loadingSection];

    QDynamicDataSection *section = [QDynamicDataSection new];
    section.title = @"Normal: with elements";
    section.bind = @"iterate:something";
    section.elementTemplate = [NSDictionary dictionaryWithObjectsAndKeys:
        @"QLabelElement", @"type",
        @"Something here", @"title",
    nil];
    [root addSection: section];

    [root bindToObject:[NSDictionary dictionaryWithObjectsAndKeys:
            [NSArray array], @"empty",
            [NSArray arrayWithObjects:@"first", @"second", nil], @"something",
            nil]];

    return root; 
}

+ (NSDictionary *) JSONDataFromJSONFile:(NSString *)jsonPath {
    Class JSONSerialization = [QRootElement JSONParserClass];
    NSAssert(JSONSerialization != NULL, @"No JSON serializer available!");

    NSError *jsonParsingError = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonPath ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (jsonData==nil)
        NSLog(@"Couldn't read any data for JSON file named: %@", jsonPath);

    NSDictionary *jsonRoot = [JSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonParsingError];

    if (jsonParsingError!=nil)
        NSLog(@"Parsing error: %@", jsonParsingError.localizedDescription);
    return jsonRoot;
}



+ (QRootElement *)create {
    QRootElement *root = [[QRootElement alloc] init];
    root.grouped = YES;
    root.title = @"QuickDialog!";
    root.controllerName = @"ExampleViewController";

    if (objc_getClass("NSJSONSerialization")!=nil) {
        QSection *sectionJson = [[QSection alloc] initWithTitle:@"JSON Samples"];

        NSDictionary *json = [self JSONDataFromJSONFile:@"kimu"];
        for (NSDictionary *dialog in json[@"dialogs"]) {
            [sectionJson addElement:[[QRootElement alloc] initWithJSON:dialog andData:nil]];
        }

        [sectionJson addElement:[[QRootElement alloc] initWithJSONFile:@"loginform"]];
        [sectionJson addElement:[[QRootElement alloc] initWithJSONFile:@"sample"]];
        [sectionJson addElement:[[QRootElement alloc] initWithJSONFile:@"jsondatasample"]];
        [sectionJson addElement:[[QRootElement alloc] initWithJSONFile:@"jsonadvancedsample"]];
        [sectionJson addElement:[[QRootElement alloc] initWithJSONFile:@"jsonremote"]];


        NSString *jsonSample = @"{\"title\": \"In memory struct\",\n"
        "    \"controllerName\": \"LoginController\", \"sections\":[]}";
        id const parsedJson = [NSJSONSerialization JSONObjectWithData:[jsonSample dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        [sectionJson addElement:[[QRootElement alloc] initWithJSON:parsedJson andData:nil]];
        [root addSection:sectionJson];
    }

	QSection *sectionSamples = [[QSection alloc] init];
    sectionSamples.footer = @"Hey there, this is a footer.";
    sectionSamples.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quickdialog"]];
    [sectionSamples addElement:[[QRootElement alloc] initWithJSONFile:@"loginform"]];
    [sectionSamples addElement:[self createSampleControls]];
    [sectionSamples addElement:[self createSampleFormRoot]];
    [sectionSamples addElement:[self reallyLongList]];

    QSection *sectionElements = [[QSection alloc] initWithTitle:@"Usage examples"];

    [sectionElements addElement:[self createLabelsRoot]];
    [sectionElements addElement:[self createEntryRoot]];
    [sectionElements addElement:[self createSlidersRoot]];
    [sectionElements addElement:[self createRadioRoot]];
    [sectionElements addElement:[[QRootElement alloc] initWithJSONFile:@"navigation"]];
    [sectionElements addElement:[self createPickerRoot]];
    [sectionElements addElement:[self createSelectRoot]];
    [sectionElements addElement:[self createMailRoot]];
    [sectionElements addElement:[self createWebAndMapRoot]];
    [sectionElements addElement:[self createTextRoot]];
    [sectionElements addElement:[self createDateTimeRoot]];
    [sectionElements addElement:[self createSortingRoot]];
    [sectionElements addElement:[self createDynamicSectionRoot]];
	[sectionElements addElement:[self createWithInitDefault]];
	[sectionElements addElement:[self createWithInitAndKey]];

    QRootElement *samplesDisabled = (QRootElement *)[self createSampleControls];
    samplesDisabled.title = @"Disabled Elements";
    for(QSection *section in samplesDisabled.sections)
    {
        for(QElement *element in section.elements)
        {
            element.enabled = NO;
        }
    }
    [sectionElements addElement:samplesDisabled];

    [root addSection:sectionSamples];
    [root addSection:sectionElements];


    return root;
}

@end
