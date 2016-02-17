//
//  NavigationMenu.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 12/17/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "NavigationMenu.h"
#import "UIButtonBox.h"
#import "KxMenu.h"

@interface NavigationMenu ()

@property (nonatomic, assign) MenuBarType topMenuBarType;
@property (nonatomic, assign) MenuBarType bottomMenuBarType;
@property (nonatomic, assign) BOOL isTopMenuActive;
@property (nonatomic, assign) BOOL isBottomMenuActive;

@property (nonatomic, strong) UIButton *notificaitonsBtn;

@end

@implementation NavigationMenu

#define TOP_MENU_BAR_HEIGHT             44
#define BOTTOM_MENU_BAR_HEIGHT          44

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kiPadLandscapeWidth, kiPadLandscapeHeight)];
    if (self) {

        // Initialization code
    }
    return self;
}


- (id)initWithTopMenuType:(MenuBarType)topMenuBarType andWithBottom:(MenuBarType)bottomMenuBarType {
    self = [super initWithFrame:CGRectMake(0, 0, kiPadLandscapeWidth, kiPadLandscapeHeight)];
    if (self) {
        self.topMenuBarType = topMenuBarType;
        self.bottomMenuBarType = bottomMenuBarType;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self commonInit];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)viewTapped:(UITapGestureRecognizer *)gesture {
    [self setHiddenMenu:YES];
}

- (BOOL)isMenuDisabled {
    return self.topMenuBarType == MenuBarDisabled && self.bottomMenuBarType == MenuBarDisabled;
}

- (UIBarButtonItem *)fixedItemwithWidth:(CGFloat)width {
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = width;
    return fixedItem;
}

- (UIBarButtonItem *)flexibleItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

//- (UIBarButtonItem *)barButtonItem:(NSString *)title withImageName:(NSString *)imageName withTag:(MenuBarButtonType)btnType {
//    CGFloat top = 4;
//    UIButtonBox *btn = [[UIButtonBox alloc] initWithFrame:CGRectMake(0, 0, 0, TOP_MENU_BAR_HEIGHT - 2 * top)];
//    btn.titleLabel.font = FONT_SANSUMI_BOLD(8.f);
//    btn.tag = btnType;
//    btn.image = [UIImage imageNamed:imageName];
//    btn.text = TRANSLATE(@"Dashboard");
//    [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    return barBtn;
//}

- (UIBarButtonItem *)barButtonItemForUserProfile:(NSString *)title withImageName:(NSString *)imageName withTag:(MenuBarButtonType)btnType {
    CGFloat top = 4;
    CustomBtn *btn = [[CustomBtn alloc] initWithFrame:CGRectMake(0, 0, 0, TOP_MENU_BAR_HEIGHT - 2 * top)];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];//FONT_SANSUMI(12.0f);
    btn.titleLabel.numberOfLines = 2;
    //    btn.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.tag = btnType;
    CGFloat padding = 5.0;
    StaffData *currentMember = [[SettingsManager sharedManager] currentMember];
    NSAttributedString *attrStr = [NSAttributedString attributedStringForButtonWithTitle:[NSString stringWithFormat:@"%@\n%@", currentMember.firstName, currentMember.lastName] withFontSize:12];
    CGFloat strWidth = [attrStr textWidth];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 5 + strWidth, 5, 32, 32)];
    [imageView sd_setImageWithURL:currentMember.photoUrl placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];
    [btn addSubview:imageView];
    [btn setAttributedTitle:attrStr forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.width = 10 + 5 + strWidth + 32 + 10;
    btn.height = TOP_MENU_BAR_HEIGHT - 2;
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setBackgroundImage:[UIImage imageFromR:108 G:108 B:108 withAlpha:1] forState:UIControlStateHighlighted];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 2 * padding, 0, 0)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

- (void)changeToOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        self.height = kiPadLandscapeWidth;
        self.width = kiPadLandscapeHeight;
    } else {
        self.width = kiPadLandscapeWidth;
        self.height = kiPadLandscapeHeight;
    }
}

- (UIBarButtonItem *)barButtonItem:(NSString *)title withImageName:(NSString *)imageName withTag:(MenuBarButtonType)btnType {
    UIBarButtonItem *barBtn;
    if (btnType == mbBackFromPatientTerminal) {
        UIButton *btn = [UIButton rightBtnWithTitle:TRANSLATE(@"Back") withImageName:imageName withController:nil withSelector:nil];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setBackgroundImage:[UIImage imageFromR:108 G:108 B:108 withAlpha:1] forState:UIControlStateHighlighted];
        btn.tag = btnType;
        barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else if (btnType == mbUserProfile) {
        return [self barButtonItemForUserProfile:title withImageName:imageName withTag:btnType];
    } else {
        CGFloat top = 4;
        UIButtonBox *btn = [[UIButtonBox alloc] initWithFrame:CGRectMake(0, 0, 0, TOP_MENU_BAR_HEIGHT - 2 * top)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12]; //FONT_SANSUMI_BOLD(11.0f);
        btn.tag = btnType;
        CGSize size = [TRANSLATE(title) sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
        btn.width = size.width + 15;
        btn.image = [UIImage imageNamed:imageName];
        btn.text = TRANSLATE(title);
        [btn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.height = TOP_MENU_BAR_HEIGHT;
        [btn setBackgroundImage:[UIImage imageFromR:108 G:108 B:108 withAlpha:1] forState:UIControlStateHighlighted];
        barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        if (btnType == mbNotifications) {
            self.notificaitonsBtn = btn;
        }
    }
    return barBtn;
}

- (void)changeButtonBackGroundColor:(UIButton *)sender {
    if (sender.isHighlighted) {
        [sender.layer setBackgroundColor:[UIColor grayColor].CGColor];
    } else {
        [sender.layer setBackgroundColor:[UIColor clearColor].CGColor];
    }
}


- (void)menuBtnClicked:(UIButtonBox *)sender {
    switch (sender.tag) {
        case mbNotes:
        case mbImages:
        case mbOtherExams:
        case mbRequest:
        case mbList:
        case mbUserProfile: {
            [self showPopupMenu:sender];
        }
            break;

        default:
            if ([self.delegate respondsToSelector:@selector(menuItemTapped:)]) {
                [self.delegate menuItemTapped:(int) sender.tag];
            }
            [self setHiddenMenu:YES];
            break;
    }
    DLog(@"btn clicked %ld", (long) sender.tag);
}

- (void)showPopupMenu:(UIButton *)sender {
    NSArray *menuItems;
    CGRect frame = sender.frame;
    frame.origin.y = sender.superview.top;
    switch (sender.tag) {
        case mbNotes: {
            menuItems =
                    @[//
//                            [KxMenuItem menuItem:TRANSLATE(@"Patient Complaints")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbPatientComplaints],
                            [KxMenuItem menuItem:TRANSLATE(@"Consent Forms")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbConsentForms],
                            [KxMenuItem menuItem:TRANSLATE(@"Post op instructions")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbPostOpInstructions],
                            [KxMenuItem menuItem:TRANSLATE(@"Clinical Notes")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbClinicalNotes],
//                            [KxMenuItem menuItem:TRANSLATE(@"Insurance Notes")
//                                          image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbInsuranceNotes],
                            [KxMenuItem menuItem:TRANSLATE(@"Monitor History")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbMonitorHistory],
                    ];
        }
            break;
        case mbImages: {
            menuItems =
                    @[
                            [KxMenuItem menuItem:TRANSLATE(@"Images")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbImages],
//
                            [KxMenuItem menuItem:TRANSLATE(@"Import Images")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbImportImages],
//                            [KxMenuItem menuItem:TRANSLATE(@"X-Ray images")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbXRayImages],
                    ];
        }
            break;
        case mbOtherExams: {
            menuItems =
                    @[
                            [KxMenuItem menuItem:TRANSLATE(@"Perio exam")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbPerioExams],
                    ];
        }
            break;
        case mbRequest: {
            menuItems =
                    @[
                            [KxMenuItem menuItem:TRANSLATE(@"Request Followup")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbRequestFlolowup],
//
//                            [KxMenuItem menuItem:TRANSLATE(@"Request another Appt.")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbRequestAnotherAppt],
//                            [KxMenuItem menuItem:TRANSLATE(@"Request treatment")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbRequestTreatment],

                            [KxMenuItem menuItem:TRANSLATE(@"Request a Lab order")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbRequestLabOrder],
                            [KxMenuItem menuItem:TRANSLATE(@"Treatments Plan")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbTreatmentsPlan],

                    ];
        }
            break;
        case mbList: {
            menuItems =
                    @[
                            [KxMenuItem menuItem:TRANSLATE(@"Call list")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbCallList],

                            [KxMenuItem menuItem:TRANSLATE(@"Waiting list")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbWaitingList],
                            [KxMenuItem menuItem:TRANSLATE(@"Missed/Cancelled List")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbMissedCancelledList],
//                            [KxMenuItem menuItem:TRANSLATE(@"Cancel list")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbCancelList],

//                            [KxMenuItem menuItem:TRANSLATE(@"Stand by")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbStandByList],
                    ];
        }
            break;
        case mbUserProfile: {
            menuItems =
                    @[
                            [KxMenuItem menuItem:TRANSLATE(@"Profile")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbProfileDetail],

                            [KxMenuItem menuItem:TRANSLATE(@"Settings")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbSettings],
//                            [KxMenuItem menuItem:TRANSLATE(@"Check in")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbCheckIn],
//
//                            [KxMenuItem menuItem:TRANSLATE(@"Check out")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbCheckOut],
//                            [KxMenuItem menuItem:TRANSLATE(@"Break")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbBreak],

                            [KxMenuItem menuItem:TRANSLATE(@"Log out")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbLogOut],
                            
#if DEBUG
//                            [KxMenuItem menuItem:TRANSLATE(@"Select Custom Font")
//                                           image:nil
//                                          target:self
//                                          action:@selector(pushMenuItem:) tag:mbSetupCustomFont],
                            [KxMenuItem menuItem:TRANSLATE(@"Custom IP Address")
                                           image:nil
                                          target:self
                                          action:@selector(pushMenuItem:) tag:mbSetupCustomBaseUrl],
#endif

                    ];
//            frame.origin.y = sender.superview.bottom;
        }
            break;

        default:
            break;
    }


    //    KxMenuItem *first = menuItems[0];
    //    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //    first.alignment = NSTextAlignmentCenter;

    [KxMenu showMenuInView:self.superview
                  fromRect:frame
                 menuItems:menuItems];
}

- (void)pushMenuItem:(KxMenuItem *)sender {
    if ([self.delegate respondsToSelector:@selector(menuItemTapped:)]) {
        [self.delegate menuItemTapped:(int) sender.tag];
    }
    [self setHiddenMenu:YES];
    NSLog(@"%@", sender);
}

//- (UIBarButtonItem *)barButtonItem:(NSString *)title withImage:(UIImage *)image withTag:(MenuBarButtonType)btnType {
////    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    [customButton setImage:image forState:UIControlStateNormal];
////    [customButton setTitle:TRANSLATE(title) forState:UIControlStateNormal];
////    customButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
////    [customButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
////    [customButton sizeToFit];
////    UIBarButtonItem *customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
////    CGFloat topPadding = 4;
////    CGFloat leftPadding = 10.f;
////    CGFloat left = leftPadding;
//    CGFloat top = 4;
//    UIButtonBox *btn = [[UIButtonBox alloc] initWithFrame:CGRectMake(0, 0, 0, TOP_MENU_BAR_HEIGHT - 2 * top)];
//    btn.titleLabel.font = FONT_SANSUMI_BOLD(10.f);
//    btn.image = image;
//    //            btn.text = [NSAttributedString attributedStringForButtonWithTitle:[TRANSLATE(@"Dashboard") uppercaseString] withBoldFontSize:10.f];
//    btn.text = TRANSLATE(@"Dashboard");
//        return nil;
//}

- (void)commonInit {
    if ([self isMenuDisabled]) {
        return;
    }
    if (self.topMenuBarType != MenuBarDisabled) {
        self.topNavigationMenu = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -TOP_MENU_BAR_HEIGHT, kiPadLandscapeWidth, TOP_MENU_BAR_HEIGHT)];
        self.topNavigationMenu.backgroundColor = COLOR(15, 15, 15);
        self.topNavigationMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        self.topNavigationMenu.barStyle = UIBarStyleBlack;
        [self configureTopMenuBar];
        [self addSubview:self.topNavigationMenu];
    }
    if (self.bottomMenuBarType != MenuBarDisabled) {
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 200) / 2, -25, 200, 25)];
//        [button setImage:[UIImage imageNamed:@"bottomMenuBarIcon.png"] forState:UIControlStateNormal];
        self.bottomNavigationMenu = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kiPadLandscapeHeight, kiPadLandscapeWidth, BOTTOM_MENU_BAR_HEIGHT)];
//        [self.bottomNavigationMenu addSubview:button];
        self.bottomNavigationMenu.backgroundColor = COLOR(15, 15, 15);
        self.bottomNavigationMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.bottomNavigationMenu.barStyle = UIBarStyleBlack;

        [self configureBottomMenuBar];
        [self addSubview:self.bottomNavigationMenu];
    }
}

- (void)configureTopMenuBar {
    switch (self.topMenuBarType) {
        case DentistProfileMenu : {
            self.topNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Dashboard" withImageName:@"dashboardMenuIcon.png" withTag:mbDashboard],
                    [self flexibleItem],
                    [self barButtonItem:@"Patients" withImageName:@"patientsMenuIcon.png" withTag:mbPatients],
                    [self flexibleItem],
                    [self barButtonItem:@"Appointments" withImageName:@"appointmentsMenuIcon.png" withTag:mbAppointments],
                    [self flexibleItem],
                    [self barButtonItem:@"Charts" withImageName:@"chartsMenuIcon.png" withTag:mbCharts],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Reports" withImageName:@"reportsMenuIcon.png" withTag:mbReports],
                    [self fixedItemwithWidth:300],
//                    [self barButtonItem:@"Tasks" withImageName:@"tasksMenuIcon.png" withTag:mbTasks],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Messages" withImageName:@"messagesMenuIcon.png" withTag:mbMessages],
//                    [self flexibleItem],
                    [self barButtonItem:@"Notifications" withImageName:@"notificationMenuIcon.png" withTag:mbNotifications],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Helpdesk" withImageName:@"helpdeskMenuIcon.png" withTag:mbHelpDesk],
                    [self flexibleItem],
                    [self barButtonItemForUserProfile:@"Fred\nHoward" withImageName:@"userProfileImageMenu.png" withTag:mbUserProfile],];
        }
            break;
        case ReceptionistProfileMenu : {
            self.topNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Dashboard" withImageName:@"dashboardMenuIcon.png" withTag:mbDashboard],
                    [self flexibleItem],
                    [self barButtonItem:@"Patients" withImageName:@"patientsMenuIcon.png" withTag:mbPatients],
                    [self flexibleItem],
                    [self barButtonItem:@"Appointments" withImageName:@"appointmentsMenuIcon.png" withTag:mbAppointments],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Reports" withImageName:@"reportsMenuIcon.png" withTag:mbReports],
                    [self fixedItemwithWidth:400],
//                    [self barButtonItem:@"Tasks" withImageName:@"tasksMenuIcon.png" withTag:mbTasks],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Messages" withImageName:@"messagesMenuIcon.png" withTag:mbMessages],
//                    [self flexibleItem],
                    [self barButtonItem:@"Notifications" withImageName:@"notificationMenuIcon.png" withTag:mbNotifications],
                    [self flexibleItem],
                    [self barButtonItem:@"Helpdesk" withImageName:@"helpdeskMenuIcon.png" withTag:mbHelpDesk],
                    [self flexibleItem],
                    [self barButtonItemForUserProfile:@"Fred\nHoward" withImageName:@"userProfileImageMenu.png" withTag:mbUserProfile],];



        }
            break;
        case CashierProfileMenu : {
            self.topNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Dashboard" withImageName:@"dashboardMenuIcon.png" withTag:mbDashboard],
                    [self flexibleItem],
                    [self barButtonItem:@"Patients" withImageName:@"patientsMenuIcon.png" withTag:mbPatients],
                    [self flexibleItem],
                    [self barButtonItem:@"Billing" withImageName:@"billingMenuIcon.png" withTag:mbAppointments],
                    [self flexibleItem],
                    [self barButtonItem:@"Reports" withImageName:@"reportsMenuIcon.png" withTag:mbReports],
                    [self fixedItemwithWidth:350],
                    [self barButtonItem:@"Tasks" withImageName:@"tasksMenuIcon.png" withTag:mbTasks],
                    [self flexibleItem],
                    [self barButtonItem:@"Messages" withImageName:@"messagesMenuIcon.png" withTag:mbMessages],
                    [self flexibleItem],
                    [self barButtonItem:@"Notifications" withImageName:@"notificationMenuIcon.png" withTag:mbNotifications],
                    [self flexibleItem],
                    [self barButtonItem:@"Helpdesk" withImageName:@"helpdeskMenuIcon.png" withTag:mbHelpDesk],
                    [self flexibleItem],
                    [self barButtonItemForUserProfile:@"Fred\nHoward" withImageName:@"userProfileImageMenu.png" withTag:mbUserProfile],];
        }
            break;
        case TechnicianProfileMenu : {
            self.topNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Dashboard" withImageName:@"dashboardMenuIcon.png" withTag:mbDashboard],
                    [self flexibleItem],
                    [self barButtonItem:@"Patients" withImageName:@"patientsMenuIcon.png" withTag:mbPatients],
                    [self flexibleItem],
                    [self barButtonItem:@"Lab Orders" withImageName:@"lab_ordersMenuIcon.png" withTag:mbAppointments],
                    [self flexibleItem],
                    [self barButtonItem:@"Reports" withImageName:@"reportsMenuIcon.png" withTag:mbReports],
                    [self fixedItemwithWidth:350],
                    [self barButtonItem:@"Tasks" withImageName:@"tasksMenuIcon.png" withTag:mbTasks],
                    [self flexibleItem],
                    [self barButtonItem:@"Messages" withImageName:@"messagesMenuIcon.png" withTag:mbMessages],
                    [self flexibleItem],
                    [self barButtonItem:@"Notifications" withImageName:@"notificationMenuIcon.png" withTag:mbNotifications],
                    [self flexibleItem],
                    [self barButtonItem:@"Helpdesk" withImageName:@"helpdeskMenuIcon.png" withTag:mbHelpDesk],
                    [self flexibleItem],
                    [self barButtonItemForUserProfile:@"Fred\nHoward" withImageName:@"userProfileImageMenu.png" withTag:mbUserProfile],];
        }
            break;
        case PatientTerminalMenu : {
            self.topNavigationMenu.items = @[[self barButtonItem:@"Back" withImageName:@"back-white.png" withTag:mbBackFromPatientTerminal],
                    [self fixedItemwithWidth:kiPadLandscapeWidth]
            ];
        }
            break;
            //
        default:
            break;
    }
}

- (void)configureBottomMenuBar {
    switch (self.bottomMenuBarType) {
        case AppointmentsCalendarMenu : {
            self.bottomNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"New Appt" withImageName:@"new_apptMenuIcon.png" withTag:mbNewAppt],
                    [self flexibleItem],
                    [self barButtonItem:@"Find Appt" withImageName:@"find_apptMenuIcon.png" withTag:mbFindAppt],
                    [self flexibleItem],
                    [self barButtonItem:@"Find open Slot" withImageName:@"find_open_slotMenuIcon.png" withTag:mbFindOpenSlot],
                    [self flexibleItem],
                    [self barButtonItem:@"List" withImageName:@"waiting_listMenuIcon.png" withTag:mbList],
//                    [self flexibleItem],
//                    [self barButtonItem:@"Reminders" withImageName:@"waiting_listMenuIcon.png" withTag:mbReminders],
                    [self fixedItemwithWidth:300],//350
                    [self barButtonItem:@"Print" withImageName:@"printMenuIcon.png" withTag:mbPrint],
                    [self flexibleItem],
                    [self barButtonItem:@"Reload" withImageName:@"refreshMenuIcon.png" withTag:mbReload],
                    [self flexibleItem],
                    [self barButtonItem:@"Switch view" withImageName:@"switch_viewMenuIcon.png" withTag:mbSwitchView]];
        }
            break;
        case WaitingListMenu :
        case CallListMenu : {
            self.bottomNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Select Multiple" withImageName:@"new_apptMenuIcon.png" withTag:mbSelectMultiple],
                    [self flexibleItem],
                    [self barButtonItem:@"Check availability" withImageName:@"check_availabilityMenuIcon.png" withTag:mbCheckAviablity],
                    [self fixedItemwithWidth:450],
                    [self barButtonItem:@"Print" withImageName:@"printMenuIcon.png" withTag:mbPrint],
                    [self flexibleItem],
                    [self barButtonItem:@"Refresh" withImageName:@"refreshMenuIcon.png" withTag:mbReload],
                    [self flexibleItem],
                    [self barButtonItem:@"Week view" withImageName:@"week_viewMenuIcon.png" withTag:mbWeekView]];
        }
            break;
        case PatientChartMenu : {
            self.bottomNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Notes" withImageName:@"notesMenuIcon.png" withTag:mbNotes],
                    [self flexibleItem],
                    [self barButtonItem:@"Images" withImageName:@"imagesMenuIcon.png" withTag:mbImages],
                    [self flexibleItem],
                    [self barButtonItem:@"Other Exams" withImageName:@"other_examsMenuIcon.png" withTag:mbOtherExams],
                    [self flexibleItem],
                    [self barButtonItem:@"Request" withImageName:@"requestMenuIcon.png" withTag:mbRequest],
                    [self flexibleItem],
                    [self barButtonItem:@"Prescriptions" withImageName:@"prescriptionsMenuIcon.png" withTag:mbPresciptions],
                    [self fixedItemwithWidth:470],
//                    [self barButtonItem:@"Lock Chart" withImageName:@"lock_chartMenuIcon.png" withTag:mbLockChart],
                    [self flexibleItem],
                    [self barButtonItem:@"Finish visit" withImageName:@"finish_visitMenuIcon.png" withTag:mbFinishVisit]];
        }
            break;
        case BillingPageMenu : {
            self.bottomNavigationMenu.items = @[[self flexibleItem],
                    [self barButtonItem:@"Make Deposit" withImageName:@"new_apptMenuIcon.png" withTag:mbMakeDeposit],
                    [self flexibleItem],
                    [self barButtonItem:@"Patient Payment" withImageName:@"find_apptMenuIcon.png" withTag:mbPatientPayment],
                    [self flexibleItem],
                    [self barButtonItem:@"Give Discount" withImageName:@"find_open_slotMenuIcon.png" withTag:mbGiveDiscount]];
        }break;
        case PatientPerioChartMenu : {
            self.bottomNavigationMenu.items = @[[self flexibleItem],
                                                [self barButtonItem:@"Save" withImageName:@"finish_visitMenuIcon.png" withTag:mbSavePerioChart]];
        }break;
            //
        default:
            break;
    }

}

- (BOOL)isMenuShowing {
    return _isTopMenuActive || _isBottomMenuActive;
}

- (void)setHiddenMenu:(BOOL)hidden {
    if (hidden || [self isMenuShowing]) {
        if (self.isBottomMenuActive) {
            [self setHiddenBottomMenu:YES];
            self.isBottomMenuActive = NO;
        }
        if (self.isTopMenuActive) {
            [self setHiddenTopMenu:YES];
            self.isTopMenuActive = NO;
        }
//        [UIView animateWithDuration:0.3 animations:^{
//            self.topNavigationMenu.top = -(self.topNavigationMenu.height + 20);
//            self.bottomNavigationMenu.top += BOTTOM_MENU_BAR_HEIGHT;//self.height + self.bottomNavigationMenu.height;//self.height + BOTTOM_MENU_BAR_HEIGHT;
//            self.bottomMenuIcon.top += BOTTOM_MENU_BAR_HEIGHT;
//            self.backgroundColor = [UIColor clearColor];
//        } completion:^(BOOL finished) {
//            self.hidden = YES;
//        }];
    }
}

- (void)setHiddenBottomMenu:(BOOL)hidden {
    if (hidden || _isBottomMenuActive) {
        _isBottomMenuActive = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomNavigationMenu.top = self.bottomNavigationMenu.bottom;
            self.bottomMenuIcon.top += BOTTOM_MENU_BAR_HEIGHT;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.hidden = NO;
        _isBottomMenuActive = YES;
        self.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomMenuIcon.top -= BOTTOM_MENU_BAR_HEIGHT;
            if([self.delegate respondsToSelector:@selector(navigationMenu:withMenuType:)]) {
                self.bottomNavigationMenu.items = [self.delegate navigationMenu:self withMenuType:self.bottomMenuBarType];
            }
            self.bottomNavigationMenu.top -= BOTTOM_MENU_BAR_HEIGHT;//self.height - self.bottomNavigationMenu.height;
        } completion:^(BOOL finished) {

        }];
    }
}

- (void)setHiddenTopMenu:(BOOL)hidden {
    if (hidden || [self isMenuShowing]) {
        _isTopMenuActive = NO;
        if (self.isBottomMenuActive) {
            [self setHiddenBottomMenu:YES];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.topNavigationMenu.top = -(self.topNavigationMenu.height + 20);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.hidden = NO;
        _isTopMenuActive = YES;
        self.alpha = 1;
        self.topNavigationMenu.top = -(TOP_MENU_BAR_HEIGHT + 20);
        if([self.delegate respondsToSelector:@selector(navigationMenu:withMenuType:)]) {
            self.topNavigationMenu.items = [self.delegate navigationMenu:self withMenuType:self.topMenuBarType];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.topNavigationMenu.top = 20;
        } completion:^(BOOL finished) {

        }];
        [self getUnreadPushNotificationsCount];
    }
}

- (void)getUnreadPushNotificationsCount {
    self.notificaitonsBtn.image = [UIImage imageNamed:@"notificationMenuIcon@2x.png"];
    [[RestClient sharedClient] callMethodByPath:METHOD_GET_PUSH_NOTIFICATION_UNREAD_COUNT withHTTPMethodType:HTTP_GET withParameters:nil
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           DLog(@"Notificaitons loaded");
                                           if (SUCCEED_RESPONSE(responseDic, error)) {
                                               self.notificaitonsBtn.image = [responseDic[@"data"] integerValue] > 0
                                                       ? [UIImage imageNamed:@"notificationActiveMenuIcon.png"]
                                                       : [UIImage imageNamed:@"notificationMenuIcon.png"];
                                           }
                                       }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
