//
//  commentViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/15.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "commentViewController.h"
#import "commentsTableViewCell.h"
#import "detailTableViewCell.h"
#import "UMSocial.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UILabel * timeLabel;

@property(nonatomic,strong) UIButton * nameButton;


@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataSource;

@property(nonatomic,strong) UIView * bview;

@end

@implementation commentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


#pragma mark --- Help Methods

- (void)setupUI{
    
    UIButton * shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25 , 25)];
    [shareBtn addTarget:self action:@selector(sharebtnClicked) forControlEvents: UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    [self.view  addSubview:self.tableView];
    [self setToolbar];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
}

- (void)setToolbar{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_WIDTH / 2, 7, 1, 30)];
    label.backgroundColor = [UIColor blackColor];
    [view addSubview:label];
    
    UIButton * commentbutton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 120, 11, 100, 25)];
    [commentbutton setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [commentbutton setTitle:@"20000" forState:UIControlStateNormal];
    [commentbutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 70)];
    [commentbutton setTitleColor:[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0] forState:UIControlStateNormal];
    [commentbutton addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view  addSubview:commentbutton];
    
    UIButton * praisebutton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 25, 11, 100, 25)];
    [praisebutton setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    [praisebutton setTitle:@"20000" forState:UIControlStateNormal];
    [praisebutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 70)];
    [praisebutton setTitleColor:[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1.0] forState:UIControlStateNormal];
    [view  addSubview:praisebutton];
    
    [self.view addSubview:view];
    
    
}

- (UIView *)tableViewheadView
{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 20, 40)];
    _titleLabel.text = @"面砖施工质量通病及防治方案汇总";
    [view addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 30)];
    _timeLabel.text = @"2015-11-25  15:28:26";
    [view addSubview:_timeLabel];
    
    _nameButton = [[UIButton alloc] initWithFrame:CGRectMake(200 + 10, 40, 100, 30)];
    [_nameButton setTitle:@"熟睡的盘子" forState:UIControlStateNormal];
    [_nameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_nameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [view addSubview:_nameButton];
    
    return view;
    
}

#pragma mark --- Events Handle
- (void)commentBtnClicked:(id)sender
{
    [self.view  addSubview:self.bview];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 80, 40)];
    textView.tag = 10;
    UILabel * placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 70, 25)];
    placeholderLabel.text = @"写评论...";
    placeholderLabel.textColor = [UIColor grayColor];
    placeholderLabel.tag = 11;
    
    textView.delegate = self;
    textView.layer.cornerRadius = 8;
    textView.clipsToBounds = YES;
    [self.bview  addSubview:textView];
    [self.bview addSubview:placeholderLabel];
    [textView becomeFirstResponder];
    
    UIButton * sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, 10, 55, 40)];
    sendBtn.backgroundColor =[UIColor whiteColor];
    sendBtn.tag = 12;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 8;
    sendBtn.clipsToBounds = YES;
    [sendBtn addTarget:self action:@selector(sendBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bview addSubview:sendBtn];
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
   _bview.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardRect.size.height - 60, SCREEN_WIDTH, 60);
}
- (void)sendBtnclicked:(id)sender{
    UITextView * textview = (UITextView *)[_bview viewWithTag:10];
    [textview resignFirstResponder];
    [_bview removeFromSuperview];
    
}
- (void)sharebtnClicked{
    //__weak personalViewController * weakSelf = self;
    [UMSocialSnsService presentSnsIconSheetView :self appKey:@"507fcab25270157b37000010" shareText:@"杭州易工科技有限公司欢迎您http://www.yg-technology.com" shareImage:[UIImage imageNamed:@"默认头像"] shareToSnsNames:@[ UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina] delegate:nil];
    
}

#pragma mark --- UITableViewDelegate,UITableViewDataSourc
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0){
    detailTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"detailCellID" forIndexPath:indexPath];

    return cell;
     }
    if (indexPath.section == 1) {
      commentsTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"commentsCellID" forIndexPath:indexPath];

        return cell;
    }
    return nil;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
    
    UIFont *tfont = [UIFont systemFontOfSize:16.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //// ios 7
        CGSize sizeText = [@"百度（Nasdaq：BIDU）是全球最大的中文搜索引擎、最大的中文网站。2000年1月由李彦宏创立于北京中关村，致力于向人们提供“简单，可依赖”的信息获取方式。“百度”二字源于中国宋朝词人辛弃疾的《青玉案·元夕》词句“众里寻他千百度”，象征着百度对中文信息检索技术的执著追求。2015年1月24日，百度创始人、董事长兼CEO李彦宏在百度2014年会暨十五周年庆典上发表的主题演讲中表示，十五年来，百度坚持相信技术的力量，始终把简单可依赖的文化和人才成长机制当成最宝贵的财富，他号召百度全体员工，向连接人与服务的战略目标发起进攻[1]  。2015年11月18日，百度与中信银行发起设立百信银行。[2] " boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText.height+ 200;
    }
    return 110;
}
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    UITextView * textview = (UITextView *)[_bview viewWithTag:10];
    [textview resignFirstResponder];
    [_bview removeFromSuperview];
}

#pragma mark --- UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    
    UIButton * button = (UIButton *)[self.view viewWithTag:12];
    button.backgroundColor = [UIColor greenColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UILabel * label = (UILabel *)[self.view viewWithTag:11];
    [label removeFromSuperview];
    
}
#pragma mark --- Getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"commentsTableViewCell" bundle:nil] forCellReuseIdentifier:@"commentsCellID"];
        [_tableView registerNib:[UINib nibWithNibName:@"detailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCellID"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.tableHeaderView = [self tableViewheadView];
        
    }
    return _tableView;
}
- (UIView *)bview {
    if (_bview == nil) {
        _bview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _bview.backgroundColor = [UIColor colorWithRed:235.0/255.0f green:235.0/255.0f blue:235.0/255.0f alpha:1.0f];
        
    }
    return _bview;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
