//
//  DSText.h
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTextCoordinator : NSObject

+ (NSString *)textForKey:(NSString *)key;
- (void)reload;

#pragma mark - texts
+ (NSString *)titleClose;
+ (NSString *)textBack;
+ (NSString *)textOK;
+ (NSString *)textPermissionError;
+ (NSString *)contentSessionExpired;
+ (NSString *)titleBought;
+ (NSString *)textCreate;
+ (NSString *)textDone;
+ (NSString *)textReviewOrder;
+ (NSString *)textRecipientsEmail;
+ (NSString *)textFrom;
+ (NSString *)textTo;
+ (NSString *)textMessage;
+ (NSString *)textCreditCardNumber;
+ (NSString *)textExpirationDate;
+ (NSString *)textCVV;
+ (NSString *)textPlaceOrder;

+ (NSString *)contentSponsorIDIsNotAvailable;

+ (NSString *)contentYourDistributorIDIs:(NSString *)distributorID;
+ (NSString *)textCreateAccountSuccessful;
+ (NSString *)contentPayOrderSuccessfully;

+ (NSString *)textAddressLine1;
+ (NSString *)textAddressLine2;

+ (NSString *)titleNoData;
+ (NSString *)titleGiftCards;
+ (NSString *)contentNoGiftCardsFound;

+ (NSString *)textPaidRank;

+ (NSString *)textNextRankRequirements;

+ (NSString *)textZip;

+ (NSString *)textAgreement;

+ (NSString *)textTerminated;
+ (NSString *)textSuspended;
+ (NSString *)textRevoked;
+ (NSString *)textInactive;
+ (NSString *)textCancelled;
+ (NSString *)textCategories;
+ (NSString *)textUnregistered;
+ (NSString *)textActive;

+ (NSString *)textPaymentFailed;
+ (NSString *)textPaymentMethod;

+ (NSString *)textPayOrder;

+ (NSString *)textShippingAddress;
+ (NSString *)textShippingMethod;

+ (NSString *)titleQualificationVolume;
+ (NSString *)titleCommissionVolume;
+ (NSString *)titleReportCustomer;
+ (NSString *)titleCustomerOrder;
+ (NSString *)titleDistributorID;
+ (NSString *)titleName;
+ (NSString *)titleEmail;
+ (NSString *)titleDelete;
+ (NSString *)titleCancel;
+ (NSString *)titleRemove;
+ (NSString *)titleActiveUntilDate;
+ (NSString *)titleCoupon;
+ (NSString *)titleDownline;
+ (NSString *)titleReports;
+ (NSString *)titleDistributors;
+ (NSString *)titleDistributor;
+ (NSString *)titleInactiveDistributors;
+ (NSString *)titleReactivationDistributors;
+ (NSString *)titleSignIn;
+ (NSString *)titleSignOut;
+ (NSString *)titleAll;
+ (NSString *)titleShopping;
+ (NSString *)titleNext;
+ (NSString *)titleBuyingBonus;
+ (NSString *)titleInDevelopment;
+ (NSString *)titleGroupEnrollment;
+ (NSString *)titleRetailCustomer;

+ (NSString *)titleLeft;
+ (NSString *)titleRight;

+ (NSString *)titleGlobal;
+ (NSString *)titleLocal;

+ (NSString *)titleCountry;
+ (NSString *)titleLevel;

+ (NSString *)titleOrders;
+ (NSString *)titleOrganization;
+ (NSString *)titleUnilevel;
+ (NSString *)titleUnilevelMatch;
+ (NSString *)titleGeneration;
+ (NSString *)titleLevelsSponsor;
+ (NSString *)titleLevelsPaid;
+ (NSString *)titleCount;
+ (NSString *)titleDualteam;
+ (NSString *)titleTotalDualteamCommissions;
+ (NSString *)titlePreviousVolume;
+ (NSString *)titleCarryoverVolume;
+ (NSString *)titleVolumePaidAfterCAP;
+ (NSString *)titlePaidRate;
+ (NSString *)titleFastTrack;
+ (NSString *)titleGenealogy;
+ (NSString *)titleRetail;
+ (NSString *)titlePoolType;
+ (NSString *)titleGlobalpoolShare;
+ (NSString *)titleAmountGlobal;
+ (NSString *)titleAmountLocal;

+ (NSString *)titleCommissionDashboard;
+ (NSString *)titleCommissionEarnings;
+ (NSString *)titleCommissionOthers;
+ (NSString *)titleWallet;
+ (NSString *)titleCommissions;
+ (NSString *)titleAutoship;

+ (NSString *)titleDashboard;
+ (NSString *)titleSettings;
+ (NSString *)titleResources;
+ (NSString *)titleStarStatus;
+ (NSString *)titleRecentOrders;
+ (NSString *)titleNews;
+ (NSString *)titleRenewal;

+ (NSString *)titleTargetRanks;
+ (NSString *)titleCurrentRank;

+ (NSString *)titleSelectDate;

+ (NSString *)titleThreeMonthsPV;

+ (NSString *)titleReviewOrder;
+ (NSString *)titleSubtotal;
+ (NSString *)titleSave;
+ (NSString *)titleSetUpAutoship;
+ (NSString *)titleSubmit;
+ (NSString *)titleBuilding;
+ (NSString *)titleUserName;
+ (NSString *)titleLifetimeRank;
+ (NSString *)titlePersonalSponsor;
+ (NSString *)titleNextRenewalDate;
+ (NSString *)titleActive;
+ (NSString *)titleTotalCommissionAmount;
+ (NSString *)titleEdit;

+ (NSString *)titleShipToName;
+ (NSString *)titleOrder;
+ (NSString *)titleOrderDate;
+ (NSString *)titleSalePrice;
+ (NSString *)titleWholesalePrice;
+ (NSString *)titleProfit;
+ (NSString *)titleVolume;
+ (NSString *)titleEarnings;
+ (NSString *)titleRank;
+ (NSString *)titlePQV;
+ (NSString *)titleYes;
+ (NSString *)titleNo;
+ (NSString *)titleOK;
+ (NSString *)titleSignUp;
+ (NSString *)titleConfirm;
+ (NSString *)titleBalance;
+ (NSString *)titleLevelMinus;
+ (NSString *)titlePaidAsLevel;
+ (NSString *)titleDistributorName;
+ (NSString *)titlePercentPaid;
+ (NSString *)titleEarningsLocal;
+ (NSString *)titleEarningsGlobal;
+ (NSString *)titleID;
+ (NSString *)titleQualifiedRank;
+ (NSString *)titlePaidRank;
+ (NSString *)titlePersonalAchievement;
+ (NSString *)titleGroupStatus;
+ (NSString *)titleGrowth;
+ (NSString *)titleGroupVolume;
+ (NSString *)titleLifetimeVolume;
+ (NSString *)titleDualteamVolume;
+ (NSString *)titleUnilevelVolume;
+ (NSString *)titleCurrentQualifiedVolume;
+ (NSString *)titlePreviousQualifiedVolume;
+ (NSString *)titlePersonalActive;

+ (NSString *)titlePGV40Sapphire;
+ (NSString *)titlePGV40Ruby;
+ (NSString *)titlePGV40Emerald;
+ (NSString *)titlePGV40Diamond;
+ (NSString *)titlePGV40BlueDiamond;
+ (NSString *)titlePGV30BlackDiamond;
+ (NSString *)titlePGV30CrownDiamond;
+ (NSString *)titlePGV30CrownAmbass;

+ (NSString *)titleLeftSideDualteamVolume;
+ (NSString *)titleRightSideDualteamVolume;

+ (NSString *)titlePersonallySponsoredTotalCount;
+ (NSString *)titlePersonallySponsoredREPAndAboveCount;
+ (NSString *)titlePersonallySponsoredConsultantAndAboveCount;
+ (NSString *)titleLeftPersonallySponsoredREPAndAboveCount;
+ (NSString *)titleRightPersonallySponsoredREPAndAboveCount;
+ (NSString *)titleLeftPersonallySponsoredConsultantAndAboveCount;
+ (NSString *)titleRightPersonallySponsoredConsultantAndAboveCount;

+ (NSString *)titleRegistration;
+ (NSString *)titleSelectCountry;
+ (NSString *)titleSummary;

+ (NSString *)titleLoginNameOrID;
+ (NSString *)titlePassword;
+ (NSString *)titleWelcome;

+ (NSString *)titleMonthly;
+ (NSString *)titleWeekly;
+ (NSString *)titleQuarterly;
+ (NSString *)titleStatement;

+ (NSString *)titleAddToCart;

+ (NSString *)titleCommissionWeekly;
+ (NSString *)titleCommissionMonthly;
+ (NSString *)titleCommissionQuarterly;
+ (NSString *)titleCommissionRank;
+ (NSString *)titleOrderNumber;
+ (NSString *)titleFastTrackVolume;

+ (NSString *)titlePerUnit;

+ (NSString *)titleMobile;
+ (NSString *)titleOutOfStock;
+ (NSString *)titleStart;

+ (NSString *)titlePublic;
+ (NSString *)titlePrivate;

+ (NSString *)titleFirstLevel;
+ (NSString *)titleGroup;

+ (NSString *)lblTotalPrice;
+ (NSString *)lblTraining;

+ (NSString *)contentRegistrationAgreement;
+ (NSString *)contentRegistrationInstruction;
+ (NSString *)contentSettingUpAutoship;
+ (NSString *)contentAutoshipOnlySupportCreditCard;
+ (NSString *)contentGoingToLogOut;
+ (NSString *)contentCouponCodeIsUnavailable;



@end
