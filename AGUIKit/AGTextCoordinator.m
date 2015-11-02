//
//  DSText.m
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGTextCoordinator.h"
#import <Foundation/Foundation.h>
#import "NSObject+Singleton.h"
#import "GlobalDefine.h"
#import "DSLocaleManager.h"

@interface AGTextCoordinator(){
    NSDictionary *data;
}

@end

@implementation AGTextCoordinator



- (id)init{
    self = [super init];
    if (self) {
        data = [NSMutableDictionary dictionary];
        [self reload];
    }
    return self;
}

- (void)reload{
    NSString *languageID = [DSLocaleManager languageID];
    [self loadPlist:languageID];
}

- (void)loadPlist:(NSString *)languageID{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *fileName = [NSString stringWithFormat:@"Text-%@", languageID];
    TLOG(@"fileName -> %@", fileName);
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    data = (NSDictionary *)[NSPropertyListSerialization
                             propertyListFromData:plistXML
                             mutabilityOption:NSPropertyListMutableContainersAndLeaves
                             format:&format
                             errorDescription:&errorDesc];
//    if (!data) TLOG(@"Error reading plist: %@, format: %lu", errorDesc, format);
//    TLOG(@"text-%@ -> %@", languageID, data);
}

+ (NSString *)textForKey:(NSString *)key{
    return [[self singleton] textForKey:key];
}

- (NSString *)textForKey:(NSString *)key{
    if ([data objectForKey:key])  return [data objectForKey:key];
    return key;
}

#pragma mark - texts





+ (NSString *)titleBought{
    return [self textForKey:@"title-bought"];
}

+ (NSString *)titleGiftCards{
    return [self textForKey:@"title-gift-cards"];
}



+ (NSString *)textCreate{
    return @"Create";
}

+ (NSString *)textDone{
    return @"Done";
}

+ (NSString *)textBack{
    return @"Back";
}




+ (NSString *)textOK{
    return @"OK";
}

+ (NSString *)textPermissionError{
    return @"Permission Error";
}










+ (NSString *)textReviewOrder{
    return @"Review Order";
}

+ (NSString *)textRecipientsEmail{
    return @"Recipient's e-mail";
}

+ (NSString *)textFrom{
    return @"From";
}

+ (NSString *)textTo{
    return @"To";
}

+ (NSString *)textMessage{
    return @"Message";
}

+ (NSString *)textCreditCardNumber{
    return @"Credit Card Number";
}

+ (NSString *)textExpirationDate{
    return @"Expiration Date";
}

+ (NSString *)textCVV{
    return @"CVV";
}

+ (NSString *)textPlaceOrder{
    return @"Place Order";
}





+ (NSString *)textCreateAccountSuccessful{
    return @"Create account successful !";
}

+ (NSString *)textAddressLine1{
    return @"Address Line 1";
}

+ (NSString *)textAddressLine2{
    return @"Address Line 2";
}

+ (NSString *)titleNoData{
    return @"NO DATA";
}

+ (NSString *)textPaidRank{
    return @"Paid Rank";
}

+ (NSString *)textNextRankRequirements{
    return @"Next Rank Requirements";
}

+ (NSString *)textZip{
    return [self textForKey:@"title-zip"];
}

+ (NSString *)textAgreement{
    return @"Agreement";
}

+ (NSString *)textTerminated{
    return @"Terminated";
}

+ (NSString *)textSuspended{
    return @"Suspended";
}

+ (NSString *)textRevoked{
    return @"Revoked";
}

+ (NSString *)textInactive{
    return @"Inactive";
}

+ (NSString *)textCancelled{
    return @"Cancelled";
}

+ (NSString *)textCategories{
    return @"Categories";
}

+ (NSString *)textUnregistered{
    return @"Unregistered";
}

+ (NSString *)textActive{
    return @"Active";
}

+ (NSString *)textPaymentFailed{
    return @"Payment Failed";
}

+ (NSString *)textPayOrder{
    return [self textForKey:@"title-pay-order"];
}

+ (NSString *)textShippingAddress{
    return [self textForKey:@"title-shipping-address"];
}

+ (NSString *)textShippingMethod{
    return [self textForKey:@"title-shipping-method"] ;
}



+ (NSString *)textPaymentMethod{
    return [self textForKey:@"title-payment-method"];
}

#pragma mark - titles

+ (NSString *)titleCommissionVolume{
    return [self textForKey:@"title-commission-volume"];
}

+ (NSString *)titleQualificationVolume{
    return [self textForKey:@"title-qualification-volume"];
}

+ (NSString *)titleReportCustomer{
    return [self textForKey:@"title-customers"];
}

+ (NSString *)titleCustomerOrder{
    return [self textForKey:@"title-customer-orders"];
}

+ (NSString *)titleDistributorID{
    return [self textForKey:@"title-distributor-id"];
}

+ (NSString *)titleName{
    return [self textForKey:@"title-name"];
}

+ (NSString *)titleEmail{
    return [self textForKey:@"title-email"];
}

+ (NSString *)titleCancel{
    return @"Cancel";
}

+ (NSString *)titleDelete{
    return @"Delete";
}

+ (NSString *)titleRemove{
    return @"Remove";
}

+ (NSString *)titleCoupon{
    return [self textForKey:@"title-coupon"];
}

+ (NSString *)titleDownline{
    return [self textForKey:@"title-downline"];
}

+ (NSString *)titleActiveUntilDate{
    return [self textForKey:@"title-active-until-date"];
}

+ (NSString *)titleReports{
    return [self textForKey:@"title-reports"];
}

+ (NSString *)titleDistributors{
    return [self textForKey:@"title-distributors"];
}

+ (NSString *)titleDistributor{
    return [self textForKey:@"title-distributor"];
}

+ (NSString *)titleInactiveDistributors{
    return [self textForKey:@"title-inactive-distributors"];
}

+ (NSString *)titleReactivationDistributors{
    return [self textForKey:@"title-reactivation-distributors"];
}

+ (NSString *)titleClose{
    return [self textForKey:@"title-close"];
}

+ (NSString *)titleSignIn{
    return [self textForKey:@"title-sign-in"];
}

+ (NSString *)titleSignOut{
    return [self textForKey:@"title-sign-out"];
}

+ (NSString *)titleAll{
    return @"All";
}

+ (NSString *)titleShopping{
    return [self textForKey:@"title-shopping"];
}

+ (NSString *)titleNext{
    return @"Next";
}

+ (NSString *)titleBuyingBonus{
    return @"Buying Bonus";
}

+ (NSString *)titleInDevelopment{
    return @"IN DEVELOPMENT";
}

+ (NSString *)titleGroupEnrollment{
    return @"Group Enrollment";
}

+ (NSString *)titleRetailCustomer{
    return @"Retail Customer";
}

+ (NSString *)titleLeft{
    return [self textForKey:@"title-left"];
}

+ (NSString *)titleRight{
    return [self textForKey:@"title-right"];
}

+ (NSString *)titleGlobal{
    return [self textForKey:@"title-global"];
}

+ (NSString *)titleLocal{
    return [self textForKey:@"title-local"];
}

+ (NSString *)titleOrders{
    return [self textForKey:@"title-orders"];
}

+ (NSString *)titleCountry{
    return [self textForKey:@"title-country"];
}

+ (NSString *)titleLevel{
    return [self textForKey:@"title-level"];
}

+ (NSString *)titleOrganization{
    return [self textForKey:@"title-organization"];
}

+ (NSString *)titleUnilevel{
    return [self textForKey:@"title-unilevel"];
}

+ (NSString *)titleUnilevelMatch{
    return [self textForKey:@"title-unilevel-match"];
}

+ (NSString *)titleGeneration{
    return [self textForKey:@"title-generation"];
}

+ (NSString *)titleLevelsSponsor{
    return [self textForKey:@"title-levels-sponsor"];
}

+ (NSString *)titleLevelsPaid{
    return [self textForKey:@"title-levels-paid"];
}

+ (NSString *)titleCount{
    return [self textForKey:@"title-count"];
}

+ (NSString *)titleDualteam{
    return [self textForKey:@"title-dualteam"];
}

+ (NSString *)titlePreviousVolume{
    return [self textForKey:@"title-previous-volume"];
}

+ (NSString *)titleCarryoverVolume{
    return [self textForKey:@"title-carryover-volume"];
}

+ (NSString *)titleTotalDualteamCommissions{
    return [self textForKey:@"title-total-dualteam-commissions"];
}

+ (NSString *)titleVolumePaidAfterCAP{
    return [self textForKey:@"title-volume-paid-after-cap"];
}

+ (NSString *)titlePaidRate{
    return [self textForKey:@"title-paid-rate"];
}

+ (NSString *)titleFastTrack{
    return [self textForKey:@"title-fast-track"];
}

+ (NSString *)titleRetail{
    return [self textForKey:@"title-retail"];
}

+ (NSString *)titlePoolType{
    return [self textForKey:@"title-pool-type"];
}

+ (NSString *)titleGlobalpoolShare{
    return [self textForKey:@"title-globalpool-share"];
}

+ (NSString *)titleAmountGlobal{
    return [self textForKey:@"title-amount-global"];
}

+ (NSString *)titleAmountLocal{
    return [self textForKey:@"title-amount-local"];
}

+ (NSString *)titleGenealogy{
    return [self textForKey:@"title-genealogy"];
}

+ (NSString *)titleCommissionDashboard{
    return [self textForKey:@"title-commission-dashboard"];
}

+ (NSString *)titleCommissionEarnings{
    return [self textForKey:@"title-commission-earnings"];
}

+ (NSString *)titleCommissionOthers{
    return [self textForKey:@"title-commission-others"];
}

+ (NSString *)titleCommissions{
    return [self textForKey:@"title-commissions"];
}

+ (NSString *)titleAutoship{
    return [self textForKey:@"title-autoship"];
}

+ (NSString *)titleWallet{
    return [self textForKey:@"title-wallet"];
}

+ (NSString *)titleDashboard{
    return [self textForKey:@"title-dashboard"];
}

+ (NSString *)titleSettings{
    return [self textForKey:@"title-settings"];
}

+ (NSString *)titleResources{
    return [self textForKey:@"title-resources"];
}

+ (NSString *)titleStarStatus{
    return [self textForKey:@"title-star-status"];
}

+ (NSString *)titleRecentOrders{
    return [self textForKey:@"title-recent-orders"];
}

+ (NSString *)titleNews{
    return [self textForKey:@"title-news"];
}

+ (NSString *)titleRenewal{
    return [self textForKey:@"title-renewal"];
}

+ (NSString *)titleTargetRanks{
    return [self textForKey:@"title-target-ranks"];
}

+ (NSString *)titleCurrentRank{
    return [self textForKey:@"title-current-rank"];
}

+ (NSString *)titleSelectDate{
    return [self textForKey:@"title-select-date"];
}



+ (NSString *)titleThreeMonthsPV{
    return @"3 Months PV";
}

+ (NSString *)titleReviewOrder{
    return [self textForKey:@"title-review-order"];
}

+ (NSString *)titleSubtotal{
    return [self textForKey:@"title-subtotal"];
}

+ (NSString *)titleSave{
    return [self textForKey:@"title-save"];
}

+ (NSString *)titleSetUpAutoship{
    return [self textForKey:@"title-set-up-autoship"];
}

+ (NSString *)titleSubmit{
    return [self textForKey:@"title-submit"];
}

+ (NSString *)titleBuilding{
    return [self textForKey:@"title-building"];
}

+ (NSString *)titleUserName{
    return [self textForKey:@"title-user-name"];
}

+ (NSString *)titleLifetimeRank{
    return [self textForKey:@"title-lifetime-rank"];
}

+ (NSString *)titlePersonalSponsor{
    return [self textForKey:@"title-personal-sponsor"];
}

+ (NSString *)titleNextRenewalDate{
    return [self textForKey:@"title-next-renewal-date"];
}

+ (NSString *)titleActive{
    return [self textForKey:@"title-active"];
}

+ (NSString *)titleEdit{
    return @"Edit";
}

+ (NSString *)titleTotalCommissionAmount{
    return [self textForKey:@"title-total-commission-amount"];
}

+ (NSString *)titleShipToName{
    return [self textForKey:@"title-ship-to-name"];
}

+ (NSString *)titleOrder{
    return [self textForKey:@"title-order"];
}

+ (NSString *)titleOrderDate{
    return [self textForKey:@"title-order-state"];
}

+ (NSString *)titleSalePrice{
    return [self textForKey:@"title-sale-price"];
}

+ (NSString *)titleVolume{
    return [self textForKey:@"title-volume"];
}

+ (NSString *)titleWholesalePrice{
    return [self textForKey:@"title-wholesale-price"];
}

+ (NSString *)titleProfit{
    return [self textForKey:@"title-profit"];
}

+ (NSString *)titleEarnings{
    return [self textForKey:@"title-earnings"];
}

+ (NSString *)titleRank{
    return [self textForKey:@"title-rank"];
}

+ (NSString *)titlePQV{
    return [self textForKey:@"title-pqv"];
}

+ (NSString *)titleYes{
    return [self textForKey:@"title-yes"];
}

+ (NSString *)titleNo{
    return [self textForKey:@"title-no"];
}

+ (NSString *)titleOK{
    return @"OK";
}

+ (NSString *)titleSignUp{
    return [self textForKey:@"title-sign-up"];
}

+ (NSString *)titleConfirm{
    return [self textForKey:@"title-confirm"];
}

+ (NSString *)titleBalance{
    return @"Balance";
}

+ (NSString *)titleLevelMinus{
    return [self textForKey:@"title-level-minus"];
}

+ (NSString *)titlePaidAsLevel{
    return [self textForKey:@"title-paid-as-level"];
}

+ (NSString *)titleDistributorName{
    return [self textForKey:@"title-distributor-name"];
}

+ (NSString *)titlePercentPaid{
    return [self textForKey:@"title-percent-paid"];
}

+ (NSString *)titleEarningsGlobal{
    return [self textForKey:@"title-earnings-global"];
}

+ (NSString *)titleEarningsLocal{
    return [self textForKey:@"title-earnings-local"];
}

+ (NSString *)titleRegistration{
    return [self textForKey:@"title-registration"];
}

+ (NSString *)titleSelectCountry{
    return [self textForKey:@"title-select-country"];
}

+ (NSString *)titleSummary{
    return [self textForKey:@"title-summary"];
}

+ (NSString *)titleID{
    return [self textForKey:@"title-id"];
}

+ (NSString *)titleQualifiedRank{
    return [self textForKey:@"title-qualified-rank"];
}

+ (NSString *)titlePaidRank{
    return [self textForKey:@"title-paid-rank"];
}

+ (NSString *)titlePersonalAchievement{
    return [self textForKey:@"title-personal-achievement"];
}

+ (NSString *)titleGroupStatus{
    return [self textForKey:@"title-group-status"];
}

+ (NSString *)titleGrowth{
    return [self textForKey:@"title-growth"];
}

+ (NSString *)titleGroupVolume{
    return [self textForKey:@"title-group-volume"];
}

+ (NSString *)titleLifetimeVolume{
    return [self textForKey:@"title-lifetime-volume"];
}

+ (NSString *)titleDualteamVolume{
    return [self textForKey:@"title-dualteam-volume"];
}

+ (NSString *)titleUnilevelVolume{
    return [self textForKey:@"title-unilevel-volume"];
}

+ (NSString *)titleCurrentQualifiedVolume{
    return [self textForKey:@"title-current-qualified-volume"];
}

+ (NSString *)titlePreviousQualifiedVolume{
    return [self textForKey:@"title-previous-qualified-volume"];
}

+ (NSString *)titlePersonalActive{
    return [self textForKey:@"title-personal-active"];
}

+ (NSString *)titlePGV40Sapphire{
    return [self textForKey:@"title-pgv40-sapphire"];
}

+ (NSString *)titlePGV40Ruby{
    return [self textForKey:@"title-pgv40-ruby"];
}

+ (NSString *)titlePGV40Emerald{
    return [self textForKey:@"title-pgv40-emerald"];
}

+ (NSString *)titlePGV40Diamond{
    return [self textForKey:@"title-pgv40-diamond"];
}

+ (NSString *)titlePGV40BlueDiamond{
    return [self textForKey:@"title-pgv40-blue-diamond"];
}

+ (NSString *)titlePGV30BlackDiamond{
    return [self textForKey:@"title-pgv30-black-diamond"];
}

+ (NSString *)titlePGV30CrownDiamond{
    return [self textForKey:@"title-pgv30-crown-diamond"];
}

+ (NSString *)titlePGV30CrownAmbass{
    return [self textForKey:@"title-pgv30-crown-ambass"];
}

+ (NSString *)titleLeftSideDualteamVolume{
    return [self textForKey:@"title-left-side-dualteam-volume"];
}

+ (NSString *)titleRightSideDualteamVolume{
    return [self textForKey:@"title-right-side-dualteam-volume"];
}

+ (NSString *)titlePersonallySponsoredTotalCount{
    return [self textForKey:@"title-personally-sponsored-total-count"];
}

+ (NSString *)titlePersonallySponsoredREPAndAboveCount{
    return [self textForKey:@"title-personally-sponsored-rep-and-above-count"];
}

+ (NSString *)titlePersonallySponsoredConsultantAndAboveCount{
    return [self textForKey:@"title-personally-sponsored-consultant-and-above-count"];
}

+ (NSString *)titleLeftPersonallySponsoredREPAndAboveCount{
    return [self textForKey:@"title-left-personally-sponsored-rep-and-above-count"];
}

+ (NSString *)titleRightPersonallySponsoredREPAndAboveCount{
    return [self textForKey:@"title-right-personally-sponsored-rep-and-above-count"];
}

+ (NSString *)titleLeftPersonallySponsoredConsultantAndAboveCount{
    return [self textForKey:@"title-left-personally-sponsored-consultant-and-above-count"];
}

+ (NSString *)titleRightPersonallySponsoredConsultantAndAboveCount{
    return [self textForKey:@"title-right-personally-sponsored-consultant-and-above-count"];
}

+ (NSString *)titleLoginNameOrID{
    return [self textForKey:@"title-login-name-or-id"];
}

+ (NSString *)titlePassword{
    return [self textForKey:@"title-password"];
}

+ (NSString *)titleWelcome{
    return [self textForKey:@"title-welcome"];
}

+ (NSString *)titleMonthly{
    return [self textForKey:@"title-monthly"];
}

+ (NSString *)titleWeekly{
    return [self textForKey:@"title-weekly"];
}

+ (NSString *)titleQuarterly{
    return [self textForKey:@"title-quarterly"];
}

+ (NSString *)titleStatement{
    return [self textForKey:@"title-statement"];
}

+ (NSString *)titleAddToCart{
    return [self textForKey:@"title-add-to-cart"];
}

+ (NSString *)titleCommissionWeekly{
    return [self textForKey:@"title-commission-weekly"];
}

+ (NSString *)titleCommissionMonthly{
    return [self textForKey:@"title-commission-monthly"];
}

+ (NSString *)titleCommissionQuarterly{
    return [self textForKey:@"title-commission-quarterly"];
}

+ (NSString *)titleCommissionRank{
    return [self textForKey:@"title-commission-rank"];
}

+ (NSString *)titleOrderNumber{
    return [self textForKey:@"title-order-number"];
}

+ (NSString *)titleFastTrackVolume{
    return [self textForKey:@"title-fast-track-volume"];
}

+ (NSString *)titlePerUnit{
    return [self textForKey:@"title-per-unit"];
}

+ (NSString *)titleMobile{
    return @"Mobile";
}

+ (NSString *)titleOutOfStock{
    return @"Out of Stock";
}

+ (NSString *)titleStart{
    return @"Start";
}

+ (NSString *)titlePublic{
    return @"Public";
}

+ (NSString *)titlePrivate{
    return @"Private";
}

+ (NSString *)titleFirstLevel{
    return @"First Level";
}

+ (NSString *)titleGroup{
    return @"Group";
}

+ (NSString *)lblTotalPrice{
    return @"Total Price";
}

+ (NSString *)lblTraining{
    return @"Training";
}



#pragma mark - contents

+ (NSString *)contentRegistrationAgreement{
    return [self textForKey:@"content-registration-agreement"];
}

+ (NSString *)contentRegistrationInstruction{
    return [self textForKey:@"content-registration-instruction"];
}

+ (NSString *)contentYourDistributorIDIs:(NSString *)distributorID{
    return [NSString stringWithFormat:@"Your %@ is %@", [AGTextCoordinator textForKey:@"title-distributor-id"],distributorID];
}

+ (NSString *)contentSessionExpired{
    return @"Session expired, please login in again. ";
}

+ (NSString *)contentPayOrderSuccessfully{
    return @"Your order has been processed successfully !";
}

+ (NSString *)contentNoGiftCardsFound{
    return @"No Gift Cards Found";
}


+ (NSString *)contentSponsorIDIsNotAvailable{
    return @"Sponsor Id doesn't exist";
}


+ (NSString *)contentSettingUpAutoship{
    return @"Set up a recurring Autoship order";
}

+ (NSString *)contentAutoshipOnlySupportCreditCard{
    return @"At this time, we only accept credit cards for Autoship orders.";
}

+ (NSString *)contentGoingToLogOut{
    return [self textForKey:@"content-going-to-log-out"];
}

+ (NSString *)contentCouponCodeIsUnavailable{
    return @"Coupon code is unavailable";
}



@end
