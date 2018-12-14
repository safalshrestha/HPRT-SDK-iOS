//
//  ViewController.m
//  samplepos
//
//  Created by 彭书旗 on 2017/7/17.
//  Copyright © 2017年 Caysn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <BLEPrintingDiscoverDelegate>

@property AppDelegate * myApp;
// 搜索到的蓝牙设备都会出现在这里了
@property NSMutableArray * arrayPeripehral;
@property NSMutableArray * arrayPeripheralName;
@property UITextField * tfRec;
@property UIScrollView * scrollView;

- (void)handleSearchBT:(id)sender;

- (void)handleConnect:(id)sender;

- (void)handleDisconnect:(id)sender;

@end

@implementation ViewController

@synthesize myApp,arrayPeripehral,arrayPeripheralName,tfRec,scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myApp.myBle.myDiscoverDelegate = self;
    arrayPeripehral = [[NSMutableArray alloc] init];
    arrayPeripheralName = [[NSMutableArray alloc] init];
    
    UIColor *randomColor = [UIColor colorWithRed:255/255. green:200/255. blue:0. alpha:1.f];
    
    self.view.backgroundColor = randomColor;
    //self.view.layer.borderColor = [UIColor orangeColor].CGColor;
    //self.view.layer.borderWidth = 2.f;
    
    int width = self.view.bounds.size.width;
    int height = self.view.bounds.size.height;
    
    UITextField * tf1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    tf1.textAlignment = NSTextAlignmentCenter;
    tf1.enabled = false;
    [self.view addSubview:tf1];
    
    UIButton * buttonDisconnect = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonDisconnect setTitle:@"断开✖️" forState:UIControlStateNormal];
    buttonDisconnect.frame = CGRectMake(width - 100, 20, 100, 60);
    buttonDisconnect.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    buttonDisconnect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [buttonDisconnect addTarget:self action:@selector(handleDisconnect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDisconnect];
    
    tfRec = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, width, 60)];
    tfRec.textAlignment = NSTextAlignmentCenter;
    tfRec.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tfRec.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tfRec.text = @"";
    tfRec.enabled = false;
    [self.view addSubview:tfRec];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, width, height - 140)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    UIButton * buttonSearchBT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonSearchBT setTitle:@"搜索" forState:UIControlStateNormal];
    buttonSearchBT.frame = CGRectMake(0, height - 60, width, 60);
    buttonSearchBT.backgroundColor = [UIColor orangeColor];
    buttonSearchBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buttonSearchBT.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [buttonSearchBT addTarget:self action:@selector(handleSearchBT:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSearchBT];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self handleSearchBT:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSearchBT:(id)sender
{
#if 1
    [arrayPeripehral removeAllObjects];
    [arrayPeripheralName removeAllObjects];
    for (UIView * subview in [scrollView subviews])
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    [myApp.myBle scan];
#endif
    
#if 0
    // IOS Simulators
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        if ([myApp.myNet Open:@"192.168.1.83" portNumber:9100]) {
            [myApp.myPos SetIO:myApp.myNet];
            [self printContent];
            [myApp.myNet Close];
        }
    }
#endif
}

- (void)printContent
{
    [myApp.myPos POS_PrintText:"测试页\n" x:-2 nWidthTimes:1 nHeightTimes:1 nFontType:0 nFontStyle:0x08 | 0x400];
    [myApp.myPos POS_PrintText:"ABCDEFGHIJKLMNOPQRSTUVWXYZ\n0123456789\n" x:0 nWidthTimes:0 nHeightTimes:0 nFontType:1 nFontStyle:0];
    [myApp.myPos POS_PrintText:"ABCDEFGHIJKLMNOPQRSTUVWXYZ\n0123456789\n\n\n" x:0 nWidthTimes:0 nHeightTimes:0 nFontType:0 nFontStyle:0];
    
    [myApp.myPos POS_PrintBarcode:"NO.20160423" x:0 nType:0x49 nUnitWidth:2 nHeight:50 nHriFontType:0 nHriFontPosition:2];
    // 注意：upc-a upc-e 等商业条码有格式限制
    [myApp.myPos POS_PrintBarcode:"20160423111" x:0 nType:0x41 nUnitWidth:2 nHeight:50 nHriFontType:0 nHriFontPosition:2];
    [myApp.myPos POS_PrintBarcode:"201604" x:0 nType:0x42 nUnitWidth:2 nHeight:50 nHriFontType:0 nHriFontPosition:2];
    [myApp.myPos POS_PrintBarcode:"201604231234" x:0 nType:0x43 nUnitWidth:2 nHeight:50 nHriFontType:0 nHriFontPosition:2];
    [myApp.myPos POS_PrintBarcode:"2016042" x:0 nType:0x44 nUnitWidth:2 nHeight:50 nHriFontType:0 nHriFontPosition:2];
    
    [myApp.myPos POS_PrintQRcode:"ABCDEFG" x:-2 nUnitWidth:6 nVersion:0 nECCLevel:4];
    [myApp.myPos POS_PrintQRcode:"电子" x:-1 nUnitWidth:6 nVersion:0 nECCLevel:4];
    [myApp.myPos POS_PrintQRcode:"电子" x:-2 nUnitWidth:6 nVersion:0 nECCLevel:4];
    [myApp.myPos POS_PrintQRcode:"电子" x:-3 nUnitWidth:6 nVersion:0 nECCLevel:4];
    
    UIImage * img = [UIImage imageNamed:@"yellowmen.png"];
    [myApp.myPos POS_PrintPicture:img x:-1 nWidth:100 nHeight:200 nBinaryAlgorithm:0 nCompressMethod:0];
    [myApp.myPos POS_PrintPicture:img x:-2 nWidth:100 nHeight:200 nBinaryAlgorithm:0 nCompressMethod:0];
    [myApp.myPos POS_PrintPicture:img x:-3 nWidth:100 nHeight:200 nBinaryAlgorithm:1 nCompressMethod:0];
    
    int ret = [myApp.myPos POS_TicketSucceed:0 timeout:10000];
    NSLog(@"%@", [NSString stringWithFormat:@"POS_TicketSucceed ret:%d", ret]);
}

- (void)handleConnect:(id)sender
{
    UIButton * btn = sender;
    
    if ([myApp.myBle IsOpened]) {
        tfRec.text = @"Please disconnect first ...\r\n";
        return;
    }
    
    [myApp.myBle stopScan];
    
    long index = [arrayPeripheralName indexOfObject:[btn titleForState:UIControlStateNormal]];
    
    CBPeripheral * peripheral = arrayPeripehral[index];
    
    tfRec.text = @"Connecting...\r\n";
    
    dispatch_async(myApp.myQueue, ^{
        // 耗时的操作
        if([myApp.myBle Open:peripheral])
        {
            [myApp.myPos SetIO:myApp.myBle];
            [myApp.myLabel SetIO:myApp.myBle];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                tfRec.text = @"Connected\r\n";
                [self dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"Open Success. Jump to print page.");
                }];
            });
            
            // 连接成功之后，打印一张测试页。
            [self printContent];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                tfRec.text = @"Failed\r\n";
            });
        }
    });
}

- (void)handleDisconnect:(id)sender
{
    [myApp.myBle Close];
    tfRec.text = @"Disconnected\r\n";
}


// BLEPrintingDelegate
- (void)didDiscoverBLE:(CBPeripheral *)peripheral address:(NSString *)address rssi:(int)rssi
{
    // 更新界面
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Handle Discovery
        if([arrayPeripehral containsObject:peripheral])
            return;
        
        [arrayPeripehral addObject:peripheral];
        
        NSString * title = [NSString stringWithFormat:@"%@ %@ (RSSI:%d)", peripheral.name, address, rssi];
        
        [arrayPeripheralName addObject:title];
        
        int width = self.view.bounds.size.width;
        //int height = self.view.bounds.size.height;
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(30, ([arrayPeripheralName count]-1)*40, width-60, 40);
        button1.backgroundColor = [UIColor lightGrayColor];
        [button1 setTitle:title  forState:UIControlStateNormal];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button1 addTarget:self action:@selector(handleConnect:) forControlEvents:UIControlEventTouchUpInside];
        scrollView.contentSize = CGSizeMake(width, [arrayPeripheralName count]*40);
        [scrollView addSubview:button1];
        
    });
}

@end

