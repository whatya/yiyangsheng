

#import "BKSegmentedVCSegue.h"


@implementation BKSegmentedVCSegue


-(void)perform {
    
    self.mainTabController = self.sourceViewController;

    [[self.mainTabController.view.subviews lastObject] removeFromSuperview];
    
    [[self.mainTabController.childViewControllers lastObject] removeFromParentViewController];
    
    UIViewController *destinationController = self.destinationViewController;
    
    [self.mainTabController addChildViewController:destinationController];
    
    [self.mainTabController.view addSubview:destinationController.view];
    
    [destinationController didMoveToParentViewController:self.mainTabController];
    
    
    self.mainTabController.edgesForExtendedLayout = UIRectEdgeNone;

    
}



@end
