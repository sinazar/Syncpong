#import "UIFont+SnapAdditions.h"
#import "HostViewController.h"
#import "JoinViewController.h"
#import "GameViewController.h"

@interface MainViewController : UIViewController <HostViewControllerDelegate, JoinViewControllerDelegate, GameViewControllerDelegate>

@property (nonatomic) BOOL _isHost;

@end