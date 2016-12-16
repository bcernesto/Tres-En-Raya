#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *buttonsArray;
UIButton *newButton;
int player=1;
int jugada=0;

- (void)viewDidLoad {
    [super viewDidLoad];

	[self addButtons];
    }

	- (void) addButtons{
float buttonWidth=self.view.bounds.size.width/3;
float buttonHeight=self.view.bounds.size.height/3;
        buttonsArray = [[NSMutableArray alloc] init];
int x=0;
int y=0;
for (int i=0; i<9; i++) {
    newButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*x+1, buttonHeight*y+1, buttonWidth, buttonHeight)];
[newButton setBackgroundColor:[UIColor blueColor]];
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
	// [newButton setTitle:@"" forState:UIControlStateNormal];
    [newButton setAccessibilityLabel:@"Casilla vacía"];
    [newButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
	newButton.tag = i;
newButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    newButton.layer.masksToBounds = YES;
	newButton.layer.cornerRadius = 5;
    newButton.layer.borderWidth = 1;
    newButton.layer.borderColor = [[UIColor blackColor] CGColor];
                 				 [buttonsArray addObject:newButton];
				 if(x==2){
				 x=0;
				 y=y+1;
				 }else{
				 x=x+1;
				 }
				 }
				 for(UIButton *button in buttonsArray){
    [self.view addSubview:button];
}
				 }

				 -(void) buttonTouched:(UIButton *) sender {
				 if([self buttonTitle:sender.tag]==nil){
    switch(player){
        case 1:
            [sender setAccessibilityLabel:@"X"];
            [sender setTitle:@"X" forState:UIControlStateNormal];
			            						            break;
        case 2:
            [sender setAccessibilityLabel:@"O"];
            [sender setTitle:@"O" forState:UIControlStateNormal];
			                        						            break;
    }
                     jugada=jugada+1;
                     int resultado=[self checkPartida];
	if(resultado>0) {
        [self finPartida:resultado];
	}else{
	[self nextTurn];
	}
	}
}

-(void) nextTurn{
switch(player){
case 1:
player=2;
break;
case 2:
player=1;
        break;
        }
}

- (int) checkPartida{
    if (([[self buttonTitle:0] isEqual:[self buttonTitle:1]])&&([[self buttonTitle:1] isEqual:[self buttonTitle:2]])) return 1;
	if (([[self buttonTitle:3] isEqual:[self buttonTitle:4]])&&([[self buttonTitle:4] isEqual:[self buttonTitle:5]])) return 1;
	if (([[self buttonTitle:6] isEqual:[self buttonTitle:7]])&&([[self buttonTitle:7] isEqual:[self buttonTitle:8]])) return 1;
	if (([[self buttonTitle:0] isEqual:[self buttonTitle:3]])&&([[self buttonTitle:3] isEqual:[self buttonTitle:6]])) return 1;
	if (([[self buttonTitle:1] isEqual:[self buttonTitle:4]])&&([[self buttonTitle:4] isEqual:[self buttonTitle:7]])) return 1;
	if (([[self buttonTitle:2] isEqual:[self buttonTitle:5]])&&([[self buttonTitle:5] isEqual:[self buttonTitle:8]])) return 1;
	if (([[self buttonTitle:0] isEqual:[self buttonTitle:4]])&&([[self buttonTitle:4] isEqual:[self buttonTitle:8]])) return 1;
	if (([[self buttonTitle:2] isEqual:[self buttonTitle:4]])&&([[self buttonTitle:4] isEqual:[self buttonTitle:6]])) return 1;
    if(jugada==9) return 2;
	return 0;
	}

	-(NSString*) buttonTitle:(int) nButton{
for(UIButton *button in buttonsArray){
    if(button.tag==nButton) return button.currentTitle;
}
				 return NULL;
				 }

-(void) finPartida:(int) resultado{
    NSString *message;
if(resultado==1) message=[NSString stringWithFormat:@"Ha ganado el jugador %i",player];
if (resultado==2) message=@"La partida ha finalizado con un empate";
	UIAlertController *alerta = [UIAlertController 
	alertControllerWithTitle:@"¡Partida terminada!" 
	message:message
	preferredStyle:UIAlertControllerStyleAlert];
UIAlertAction *ok = [UIAlertAction 
actionWithTitle:@"OK" 
style:UIAlertActionStyleDefault 
handler:^(UIAlertAction *action) 
{
[alerta dismissViewControllerAnimated:YES completion:nil];
player=0;
}];
[alerta addAction:ok];
[self presentViewController:alerta animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

				 @end
