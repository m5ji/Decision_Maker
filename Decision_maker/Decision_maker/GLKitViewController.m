//
//  GLKitViewController.c
//  Decision_maker
//
//  Created by MIngu Ji on 2014-08-03.
//  Copyright (c) 2014 MIngu Ji. All rights reserved.
//

#import "GLKitViewController.h"
#import "SecondViewController.h"
#import "dude_thinking_.h"



@interface GLKitViewController ()
{
    float   rotate;
}

@property (strong, nonatomic) GLKBaseEffect* effect;

@end

@implementation GLKitViewController
@synthesize _answers;
@synthesize _temp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create effect
    [self createEffect];
    
    // Set up context
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    glEnable(GL_CULL_FACE);
    [EAGLContext setCurrentContext:context];
    
    // Set up view
    GLKView* glkview = (GLKView *)self.view;
    glkview.context = context;
    
    // Variables
    rotate = 0.0f;
    
    // OpenGL ES Settings
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Prepare effect
    [self.effect prepareToDraw];

    // Set matrices
    [self setMatrices];
    
    // 1
    // Positions
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, dude_thinkingVerts);
    
    // Normals
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 0, dude_thinkingNormals);
    
    // 2
    // Draw Model
    glDrawArrays(GL_TRIANGLES, 0, dude_thinkingNumVerts);
}

- (void)setMatrices
{
    // Projection Matrix
    const GLfloat aspectRatio = (GLfloat)(self.view.bounds.size.width) / (GLfloat)(self.view.bounds.size.height);
    const GLfloat fieldView = GLKMathDegreesToRadians(20.0f);
    const GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(fieldView, aspectRatio, 0.1f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    // ModelView Matrix
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 0.0f, 0.0f, -5.0f);
    modelViewMatrix = GLKMatrix4RotateX(modelViewMatrix, GLKMathDegreesToRadians(0.0f));
    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, GLKMathDegreesToRadians(rotate));
                                        
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}

- (void)createEffect
{
    // Initialize
    self.effect = [[GLKBaseEffect alloc] init];
    
    // Light
    self.effect.useConstantColor = GL_TRUE;
    self.effect.colorMaterialEnabled = GL_TRUE;
    self.effect.constantColor = GLKVector4Make(0.5f, 0.5f, 0.5f, 1.0f);
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.position = GLKVector4Make(0.5f, 0.5f, 0.0f, 0.0f);
    
    /*
    // Texture
     self.effect.texture2d0.envMode = GLKTextureEnvModeModulate;
     self.effect.texture2d0.target = GLKTextureTarget2D;
     self.effect.texture2d0.enabled = true;
     */
}

- (void)update
{
    rotate -= 1.0f;
    if (rotate == -30.0f)
    {
        [self performSegueWithIdentifier:@"secondview" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (([[segue identifier] isEqualToString:@"secondview"]))
    {
        SecondViewController *secondview = (SecondViewController *)segue.destinationViewController;
        secondview._answers = _answers;
        secondview.temp_ = _temp;
    }
}

@end