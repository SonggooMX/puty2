//
//  Print.h
//  BTDemo
//
//  Created by ble on 14-10-31.
//
//状态查询指令值
#define DLE_EOT_1 1
#define DLE_EOT_3 3
#define DLE_EOT_4 4
//二维条码类型
#define POS_BT_PDF417       0
#define POS_BT_DATAMATRIX   1
#define POS_BT_QRCODE       2
//一维条码文字位置
#define POS_BT_HT_NONE      0
#define POS_BT_HT_UP        1
#define POS_BT_HT_DOWN      2
#define POS_BT_HT_BOTH      3
//一维条码类型
#define POS_BT_UPCA         65
#define POS_BT_UPCE         66
#define POS_BT_JAN13        67
#define POS_BT_JAN8         68
#define POS_BT_CODE39       69
#define POS_BT_ITF          70
#define POS_BT_CODABAR      71
#define POS_BT_CODE93       72
#define POS_BT_CODE128      73

#define BUF_SIZE            800*1024
#define GET_NUM             155

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "RepeatCount.h"
#import "HomeBottomViewController.h"


static int head=-1,tail=-1;
//static BOOL timerStarted = NO;
static Byte sndBuf[BUF_SIZE];
static BOOL isBuffedWrite = YES;
static BOOL taskInRunning = NO;
static NSMutableData *lastData = nil;
static int currentPrintStatus=-1;//当前打印机状态


//固定指令
static  Byte ORDER_QUERY_LEN[] = {0x1D, 0x28, 0x48, 0x02, 0x00, 0x31, 0x30};
static  Byte ORDER_QUERY_BATTERY[] = {0x1D, 0x28, 0x48, 0x02, 0x00, 0x32, 0x30};
static  Byte ORDER_QUERY_CONNECT_TYPE[] = {0x1D, 0x28, 0x48, 0x02, 0x00, 0x33, 0x30};
static  Byte ORDER_ONE_LINE[] = {0x15, 0x01};


@interface Print : UIViewController

@property HomeBottomViewController *parent;
@property int sendDataComplete;//数据发送完毕

/*******************************************************************
 函数名：printtxt
 功能：向打印机发送文本打印数据或控制命令
 参数：
 data 数据或控制命令
 
 返回：
 YES 成功
 NO 失败
 *******************************************************************/
    - (BOOL) printTxt:(NSString *)data;

/*******************************************************************
函数名：printbin
功能：向打印机发送二进制打印数据或控制命令
参数：
        data 数据或控制命令

返回：
            YES 成功
            NO 失败
 *******************************************************************/
	- (BOOL) printBin:(NSData *)data;


/*******************************************************************
函数名：sendCheckOfflineCmd,发送指令：DLE EOT n（0x10 0x04 1）
功能：发送询问打印机脱机检查指令，受限于ble4.0的限制，程序不能顺序执行接收打印机的
    返回，只能在委托响应函数didDataReceived中处理收到的查询结果
参数:
     无
返回：
            YES 发送成功
            NO 发送失败
*******************************************************************/
    - (BOOL) sendCheckOfflineCmd;

/*******************************************************************
 函数名：sendCheckPaperOutCmd,发送指令：DLE EOT n（0x10 0x04 4）
 功能：发送询问打印机缺纸检查指令，受限于ble4.0的限制，程序不能顺序执行接收打印机的
 返回，只能在委托响应函数didDataReceived中处理收到的查询结果
 参数:
        无
 返回：
        YES 发送成功
        NO 发送失败
 *******************************************************************/
- (BOOL) sendCheckPaperOutCmd;

/*******************************************************************
 函数名：SendCheckErrorCmd,发送指令：DLE EOT n（0x10 0x04 3）
 功能：发送询问打印机是否有错检查指令，受限于ble4.0通讯的限制，程序不能顺序执行接收打印机的
 返回，只能在委托响应函数didDataReceived中处理收到的查询结果
 参数:
        无
 返回：
        YES 发送成功
        NO 发送失败
 *******************************************************************/
- (BOOL) sendCheckErrorCmd;

/*******************************************************************
 函数名：printAlignXXX,发送指令：ESC a n(0/0x30:左 1/0x31:中 1/0x32:右)
 功能：调整对齐方式
 参数:
    无
 返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) printAlignLeft;
- (BOOL) printAlignCenter;
- (BOOL) printAlignRight;

/*******************************************************************
 函数名：print2DBarCode,
    发送类型选择指令：GS Z n(1d 5a n选择0:pdf417,1:datamatrix,2:qr-code)
    发送打印指令：ESC Z v r k nl nh d1...dn(1b 5a v r k nl nh d1...dn打印，具体参数参见指令手册）
 功能：打印二维条码
 参数:
    type:0-pdf417,1-datamatrix,2-qr-code
    v、r:对不同类型条码含义不同
    data：条码内容
 
    如下是指令的详细说明
    ① PDF417二维条码
		1 ≤ v ≤ 30 表示每行字符数。不同的机型由于纸宽不同，v的最大值应该在该机型允许的最大值之内。
		0 ≤ r ≤ 8 表示纠错等级。
		② DATA MATRIX二维条码
		0 ≤v ≤ 144 表示图形高(0：自动选择)。
		8 ≤ r ≤ 144 表示图形宽(v=0时，无效)。
		③ QR CODE二维条码
		0 ≤ v ≤ 40 表示图形版本号(0：自动选择)。
		r =76,77,81,72 表示纠错等级(L:7%, M:15%,Q:25%,H:30%)。
		· 参数k, n(nL, nH), d参数含义。
		1 ≤ k ≤ 6 表示纵向放大倍数。
		1 ≤ n ≤ 65535 表示打印条码的数据长度为n，nL, nH为n的低位和高位(n= dL + dH × 256)。
		0 ≤ dn ≤ 255 表示条码数据。
 返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) print2DBarCode:(int)type para1:(int)v para2:(int)r para3:(int)k content:(NSData*)data;

/*******************************************************************
 函数名：print1DBarCode,
    发送设置宽度指令：GS W n(1d 77 n，2≤ n≤ 6）
    发送设置高度指令：GS h n(1d 68 n，1≤ n≤ 255）
    发送条码文字位置指令：GS H n（1d 48 n， 0：不打印 1：打印在条码上方 2：下方 3：上下都打）
    发送打印指令：GS k m d1...dk nul(1d 6b m d1...dk 00）
            或GS k m n d1...dn(1d 6b m n d1...dn)
 功能：打印一维条码
 参数:
    type：条码类型,参见下面m条码类型说明
    w:条码宽度，2≤ n≤ 6
    h:条码高度，1≤ n≤ 255
    position：条码文字位置
            0：不打印 1：打印在条码上方 2：下方 3：上下都打
    data：条码内容
 
    条码类型其他说明
        [范围]   ①0 ≤ m ≤ 6 （k和d的取值范围是由条码类型来决定）
                ②65 ≤ m ≤ 73 （k 和d 的取值范围是由条码类型来决定）
        [描述] 选择一种条码类型并打印条码
        m 用来选择条码类型，如下所示：
        m 条码类型 字符个数 d
      ① 0 UPC-A 11 ≤ k ≤ 12 48 ≤ d ≤ 57
        1 UPC-E 11 ≤ k ≤ 12 48 ≤ d ≤ 57
        2 JAN13 (EAN13) 12 ≤ k ≤ 13 48 ≤ d ≤ 57
        3 JAN 8 (EAN8) 7 ≤ k ≤ 8 48 ≤ d ≤ 57
        4 CODE39 1 ≤ k ≤ 255 45 ≤ d ≤ 57, 65 ≤ d ≤ 90, 32, 36,37,43
        5 ITF 1 ≤ k ≤ 255 48 ≤ d ≤ 57
        6 CODABAR 1 ≤ k ≤ 255 48 ≤ d ≤ 57, 65 ≤ d ≤ 68 , 36, 43,45,46,47,58
      ② 65 UPC-A 11 ≤ n ≤12 48 ≤ d ≤ 57
         66 UPC-E 11 ≤ n ≤12 48 ≤ d ≤ 57
        67 JAN13 (EAN13) 12 ≤n ≤ 13 48 ≤ d ≤ 57
        68 JAN 8 (EAN8) 7 ≤n ≤ 8 48 ≤ d ≤ 57
        69 CODE39 1 ≤ n ≤255 45 ≤ d ≤ 57, 65 ≤ d ≤ 90, 32, 36,37,43
            d1 = dk = 42
        70 ITF 1 ≤ n≤ 255 48 ≤ d ≤ 57
        71 CODABAR 1 ≤ n≤ 255 48 ≤ d ≤ 57 65 ≤ d ≤ 68, 36,43,45,46,47 58
        72 CODE93 1 ≤ n≤ 255 0 ≤ d ≤ 127
        73 CODE128 2 ≤ n≤ 255 0 ≤ d ≤ 127

 返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) print1DBarCode:(int)type width:(int)w height:(int)h txtpositon:(int)positon content:(NSData*)data;

/*******************************************************************
 函数名：buffedWriteCtrl
 功能：开关缓冲打印
 由于蓝牙底层的限制，直接往打印机送数据在一次任务/线程中只能送2k左右字节，如果
 打印的单据超过这个限制，后面的数据无法发送成功，只能打开缓冲方式打印，数据先缓冲后再通过
 定时任务打印
 参数:
        YES 打开缓冲打印
        NO 关闭缓冲打印
 返回：
        无
 *******************************************************************/
- (void) buffedWriteCtrl:(BOOL)isBuffed;

/*******************************************************************
 函数名：printBitMap，
    发送位图指令：ESC * m nl nh d1...dn(1b 2a m nl nh dl...dk)
 功能：打印一个位图，具体说明参见参考手册
 参数：
        mode    0：8点单密度 1：8点双密度 32：24点单密度  33：24点双密度
        bm      位图数据
 
返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) printBitMap:(int)mode bitmap:(NSData*)bm;

/*******************************************************************
 函数名：setLineHeight
 发送位图指令：ESC 3 n(1b 33 n)
 功能：设置行高(或者说行间距)
 参数：
    0≤ n ≤255,系统缺省值是32，相当于4mm或1/6英寸
 返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) setLineHeight:(int)n;

/*******************************************************************
 函数名：restoreDefaultLineHeight
 发送位图指令：ESC 2 (1b 32)
 功能：恢复默认行高
 参数：
    无
 返回：
    YES 成功
    NO 失败
 *******************************************************************/
- (BOOL) restoreDefaultLineHeight;

/*******************************************************************
 函数名：setChineseWordFormat
 发送位图指令：FS ! n (1c 21 n)
 功能：设置中文字符的打印格式:倍高、倍宽、下划线
 参数：
    isDoubleHeight  NO:清除倍高设置
                    YES:设置为倍高
    isDoubleWidth   NO:清除倍宽设置
                    YES:设置为倍宽
    isUnderLine     NO:清除下划线设置
                    YES:设置为下划线打印
 返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) setChineseWordFormat:(BOOL)isDoubleHeight doubleWidth:(BOOL)isDoubleWidth underline:(BOOL)isUnderLine;

/*******************************************************************
 函数名：setAsciiWordFormat
 发送位图指令：ESC ! n (1b 21 n)
 功能：设置标准ascii字体A(12X24)或压缩ascii字体B(9X17)的打印格式
 参数：
    type            0:标准ascii字体A(12X24)
                    1:压缩ascii字体B(9X17)
    isbold          NO:清除加粗设置
                    YES:设置为加粗打印
    isDoubleHeight  NO:清除倍高设置
                    YES:设置为倍高
    isDoubleWidth   NO:清除倍宽设置
                    YES:设置为倍宽
    isUnderLine     NO:清除下划线设置
                    YES:设置为下划线打印
  返回：
        YES 成功
        NO 失败
 *******************************************************************/
- (BOOL) setAsciiWordFormat:(int)type bold:(BOOL)isbold doubleHeight:(BOOL)isDoubleHeight doubleWidth:(BOOL)isDoubleWidth underline:(BOOL)isUnderLine;



/*******************************************************************
 函数名：putInBuf，请不要直接调用，缓冲打印方式的时候自动调用
 功能：将打印数据放入发送缓冲区
 参数:
      待打印的数据或控制指令
 返回：
        YES 成功
        NO 失败，发送缓冲区空间不足
 *******************************************************************/
- (BOOL) putInBuf:(NSData *)data;

/*******************************************************************
 函数名：getFromBuf，请不要直接调用，缓冲打印方式的时候自动调用
 功能：从缓冲区取数据送打印机，最多100个字节
 参数:
     取到得待打印的数据或控制指令
 返回：
     取到字节数
 *******************************************************************/
- (NSData *)getFromBuf;


/********************************************************************
 函数名：SendTask，请不要直接调用，缓冲打印方式的时候自动调用
 功能：缓冲打印的定时任务，0.1秒执行一次，每次发送100字节，如果失败等待2秒后重发
 由于蓝牙底层的限制，直接往打印机送数据在一次任务/线程中只能送2k字节，如果打印的
 单据超过这个限制，后面的数据无法发送成功，只能打开缓冲方式打印，数据先缓冲后再通过
 定时任务打印
********************************************************************/
- (void) SendTask;

/********************************************************************
 函数名：isBuffEmpty，请不要直接调用，缓冲打印方式的时候自动调用
 功能：判断打印机缓冲区是否空
 返回：
    YES 缓冲区空
    NO 缓冲区非空
 ********************************************************************/

- (BOOL) isBuffEmpty;

/********************************************************************
 函数名：printPng
 功能:打印png图片s
 参数:
      待打印的文件名
 返回：
    YES 缓冲区空
    NO 缓冲区非空
 ********************************************************************/
- (BOOL) printPNG_JPG:(NSString *)filename;
- (BOOL) printImage:(UIImage *)image;

/********************************************************************
 函数名：cutPaper
 功能:切纸,注意该功能要在行首调用，比如上一行有一个回车或换行符
 参数:
    mode 切纸模式
				0，1，48，49: 半切
				65，66:进纸（切纸位置+[n ×（纵向移动单位）英寸]）并且半切纸
    dis  走纸距离,单位为纵向移动单位(纵向移动单位的缺省值是打印机的一个点，通过GS P指令可以设置)
 返回：
    YES 成功
    NO 失败
 ********************************************************************/
- (BOOL) cutPaper:(int) mode feed_distance:(int) dis;

/********************************************************************
 函数描述:设置打印机浓度
 参数描述:(1)参数 desity，代表需要设置的浓度参数，取值 从 0 到 14，14 是最浓
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 *******************************************************************/
- (BOOL) setPrintDesity:(int) desity;

/******************************************************************
 函数描述:设置打印机打印速度
 参数描述:(1)参数 speed，代表需要设置的速度参数，取值 从 0 到 4，4 是最快
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) setPrintSpeed:(int) speed;

/******************************************************************
 函数描述:设置打印机打印质量
 参数描述:(1)参数 qulity，代表需要设置的速度参数，取值 从 0 到 2，2 是最高
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) setPrintQulity:(int) qulity;

/******************************************************************
 函数描述:设置打印机纸张类型
 参数描述:(1)参数 type，代表需要设置的纸张类型，其中 1. type 等于 0 的时候，代表连续纸
 2. type 等于 1 的时候，代表黑标纸 3. type 等于 2 的时候，代表间隙纸
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) setPageType:(int) type;

/******************************************************************
 函数描述:获取打印机状态
 参数描述:(1)参数 n，代表获取不同信息的标志，其中 1. n 等于 1 的时候，传输打印机状态
 2. n 等于 2 的时候，传输脱机状态
 3. n 等于 3 的时候，传输错误状态
 4. n 等于 4 的时候，传输纸传感器状态
 函数返回值:(1) 当获取失败的时候返回-1
 (2) 当成功获取的时候返回一个整型数 data
 ******************************************************************/
- (BOOL) getPrinterStatus:(int) n;
- (BOOL) getPrinterStatus2:(int)n;

/******************************************************************
 函数描述:查询打印机信息
 参数描述:(1)参数 n，代表获取不同信息的标志，其中
 1. n 等于 65 的时候，获取 Firmware 版本 ID
 2. n 等于 66 的时候，获取厂商
 3. n 等于 67 的时候，获取打印机名称 4. n 等于 68 的时候，获取打印机序列号 5. n 等于 69 的时候，获取支持汉字类型 6. n 等于 70 的时候，获取蓝牙 MAC 地址
 函数返回值:(1) 当获取失败的时候返回 null
 (2) 当成功获取的时候返回一个字符串具体内
 ******************************************************************/
- (BOOL) findPrinterInfo:(int) n;

/******************************************************************
 函数描述:获取色带情况
 参数描述:无
 函数返回值:(1)如果返回 null,代表打印机未连接 (2)如果返回{-1,-1},代表获取失败
 (3)如果返回不等于-1 的数，则代表获取成功
 ******************************************************************/
- (BOOL) queryLen;

/******************************************************************
 函数描述:获取电池电压信息
 参数描述:无
 函数返回值:(1)如果返回-1，则代表获取失败 (2)如果返回大于 0 的数，代表获取成功
 注意:电池充满电的电压是 8.4 等于 7.4 的时候，需要充电
 小于或等于 7.0 的时候，打印机不能打印
 ******************************************************************/
- (BOOL) getPrintV;

/******************************************************************
 函数描述:获取连接介质
 参数描述:无
 函数返回值:(1)返回值 n
 1. n 等于 1 的时候，代表是蓝牙连接状态
 2. n 等于 2 的时候，代表是 wifi 连接状态
 ******************************************************************/
- (int) queryConnectStatus;

- (NSData*) startPrintOrder:(int)nL lenH:(int)nH spaceLH:(int)sL spaceNH:(int)sH width:(int)fw device:(int) de pcs:(int) l1 seq:(int) l2 data1:(int) d1 data2:(int) d2 data3:(int) d3 data4:(int) d4;

/******************************************************************
 函数描述:打印标签
 参数描述:(1)参数 label，代表要打印的标签 (2)参数 labelWidth，标签的宽，单位毫米
 (3)参数 labelHeight，标签的高，单位毫米
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) printLabel:(UIImage*)bitmap lw:(int)labelWidth lh:(int)labelHeight pt:(int)pageType pageTotal:(int) total pageIndex:(int) index;

/******************************************************************
 函数描述:打印直线
 参数描述: (1)参数 start,代表开始的点数 (2)参数 end，代表结束的点数
 (3)参数 height，代表行的点数
 注意:一行有 384 个点，每个点为 0.125 毫米
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) drawLine:(int) start to:(int) end lh:(int) height;


/******************************************************************
 函数描述:关机指令
 参数描述: 无
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) powerOff;

/******************************************************************
 函数描述:下载位图指令
 参数描述: (1)参数 bitmap，需要下载到打印机位图 (2)参数 position，下载到打印机的文件号
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) onDownImgIntoPrinter:(UIImage*) bitmap to:(int) position;

/******************************************************************
 函数描述:打印下载位图
 参数描述: (1)参数 n，打印下载位图的文件号
 函数返回值:(1)返回 true 的时候，则代表执行指令成功 (2)返回 false 的时候，则代表执行指令失败
 ******************************************************************/
- (BOOL) onPrintDownPrinter:(int) n;

@end
