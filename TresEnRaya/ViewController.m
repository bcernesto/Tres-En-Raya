#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *arrayDeBotones;
UIButton *nuevoBoton;
UIView *menu;
float anchoVentana;
float altoVentana;
int jugador=1;
int jugada=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    anchoVentana=self.view.bounds.size.width;
    altoVentana=self.view.bounds.size.height;
	[self agregarBotones];
    }

	- (void) agregarBotones{
float anchoBoton=anchoVentana/3;
float altoBoton=altoVentana/3;
        arrayDeBotones = [[NSMutableArray alloc] init];
int x=0;
int y=0;
for (int i=0; i<9; i++) {
    nuevoBoton = [[UIButton alloc] initWithFrame:CGRectMake(anchoBoton*x+1, altoBoton*y+1, anchoBoton, altoBoton)];
[nuevoBoton setBackgroundColor:[UIColor blueColor]];
    [nuevoBoton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nuevoBoton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
	    [nuevoBoton setAccessibilityLabel:@"Casilla vacía"];
    [nuevoBoton addTarget:self action:@selector(botonPulsado:) forControlEvents:UIControlEventTouchUpInside];
	nuevoBoton.tag = i;
nuevoBoton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    nuevoBoton.layer.masksToBounds = YES;
	nuevoBoton.layer.cornerRadius = 5;
    nuevoBoton.layer.borderWidth = 1;
    nuevoBoton.layer.borderColor = [[UIColor blackColor] CGColor];
                 				 [arrayDeBotones addObject:nuevoBoton];
				 if(x==2){
				 x=0;
				 y=y+1;
				 }else{
				 x=x+1;
				 }
				 }
				 for(UIButton *boton in arrayDeBotones){
    [self.view addSubview:boton];
}
				 }

				 -(void) botonPulsado:(UIButton *) sender {
				 if((jugador>0)&&([self tituloBoton:sender.tag]==nil)){
    switch(jugador){
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
                     int resultado=[self ComprobarPartida];
	if(resultado>0) {
        [self finPartida:resultado];
	}else{
	[self turnoSiguiente];
	}
	}
}

-(void) turnoSiguiente{
switch(jugador){
case 1:
jugador=2;
break;
case 2:
jugador=1;
        break;
        }
}

- (int) ComprobarPartida{
    if (([[self tituloBoton:0] isEqual:[self tituloBoton:1]])&&([[self tituloBoton:1] isEqual:[self tituloBoton:2]])) return 1;
	if (([[self tituloBoton:3] isEqual:[self tituloBoton:4]])&&([[self tituloBoton:4] isEqual:[self tituloBoton:5]])) return 1;
	if (([[self tituloBoton:6] isEqual:[self tituloBoton:7]])&&([[self tituloBoton:7] isEqual:[self tituloBoton:8]])) return 1;
	if (([[self tituloBoton:0] isEqual:[self tituloBoton:3]])&&([[self tituloBoton:3] isEqual:[self tituloBoton:6]])) return 1;
	if (([[self tituloBoton:1] isEqual:[self tituloBoton:4]])&&([[self tituloBoton:4] isEqual:[self tituloBoton:7]])) return 1;
	if (([[self tituloBoton:2] isEqual:[self tituloBoton:5]])&&([[self tituloBoton:5] isEqual:[self tituloBoton:8]])) return 1;
	if (([[self tituloBoton:0] isEqual:[self tituloBoton:4]])&&([[self tituloBoton:4] isEqual:[self tituloBoton:8]])) return 1;
	if (([[self tituloBoton:2] isEqual:[self tituloBoton:4]])&&([[self tituloBoton:4] isEqual:[self tituloBoton:6]])) return 1;
    if(jugada==9) return 2;
	return 0;
	}

	-(NSString*) tituloBoton:(int) tagBoton{
for(UIButton *boton in arrayDeBotones){
    if(boton.tag==tagBoton) return boton.currentTitle;
}
				 return NULL;
				 }

-(void) finPartida:(int) resultado{
    NSString *mensajeAlerta;
if(resultado==1) mensajeAlerta=[NSString stringWithFormat:@"Ha ganado el jugador %i",jugador];
if (resultado==2) mensajeAlerta=@"La partida ha finalizado con un empate";
	UIAlertController *alerta = [UIAlertController 
	alertControllerWithTitle:@"¡Partida terminada!" 
	message:mensajeAlerta
	preferredStyle:UIAlertControllerStyleAlert];
UIAlertAction *ok=[UIAlertAction 
actionWithTitle:@"Aceptar" 
style:UIAlertActionStyleDefault 
handler:^(UIAlertAction *action) 
{
[alerta dismissViewControllerAnimated:YES completion:nil];
[self menuPartida:mensajeAlerta];
}];
[alerta addAction:ok];
[self presentViewController:alerta animated:YES completion:nil];
}

-(void) menuPartida:(NSString*) mensaje{
jugador=0;
jugada=0;
for(UIButton *boton in arrayDeBotones){
[boton removeFromSuperview];
}
[arrayDeBotones removeAllObjects];
menu = [[UIView alloc]
        initWithFrame:CGRectMake(20,20,anchoVentana-40,altoVentana-40)];
    	float anchoVistaMenu=menu.bounds.size.width;
	float altoVistaMenu=menu.bounds.size.height;
UILabel *MenuEtiqueta = [[UILabel alloc]
initWithFrame:CGRectMake(0,0,anchoVistaMenu,altoVistaMenu/4*3)];
MenuEtiqueta.text=[NSString stringWithFormat:@"Partida terminada. %@", mensaje];
[menu addSubview:MenuEtiqueta];
UIButton *menuBoton = [[UIButton alloc]
initWithFrame:CGRectMake(0,altoVistaMenu/4*3+1,anchoVistaMenu,altoVistaMenu/4)];
[menuBoton setBackgroundColor:[UIColor blueColor]];
    [menuBoton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuBoton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
	[menuBoton setTitle:@"Jugar de nuevo" forState:UIControlStateNormal];
        [menuBoton addTarget:self action:@selector(jugarDeNuevo:) forControlEvents:UIControlEventTouchUpInside];
	menuBoton.tag = 9;
menuBoton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    menuBoton.layer.masksToBounds = YES;
	menuBoton.layer.cornerRadius = 5;
    menuBoton.layer.borderWidth = 1;
    menuBoton.layer.borderColor = [[UIColor blackColor] CGColor];
[menu addSubview:menuBoton];
		[self.view addSubview:menu];
}

-(void) jugarDeNuevo:(UIButton *) sender {
[menu removeFromSuperview];
[self agregarBotones];
jugador=1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

				 @end
