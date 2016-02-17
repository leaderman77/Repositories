//
//  RepositoriesDetailsViewController.h
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "BaseController.h"

@interface RepositoriesDetailsViewController : BaseController
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *repoDescriptionString;
@property (nonatomic, strong) NSString *issuesString;
@property (nonatomic, strong) NSString *watchersString;
@property (nonatomic, strong) NSString *followersString;
@end
