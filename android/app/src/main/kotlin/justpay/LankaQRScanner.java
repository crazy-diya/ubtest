package justpay;

import com.google.gson.Gson;
import com.mastercard.mpqr.pushpayment.model.AdditionalData;
import com.mastercard.mpqr.pushpayment.model.PushPaymentData;
import com.mastercard.mpqr.pushpayment.model.UnrestrictedData;
import com.mastercard.mpqr.pushpayment.parser.Parser;

public class LankaQRScanner {
    public  static String LQRErrorCode = "LQRError";
    public  static String InvalidLQR = "Invalid QR";

    public static String getLankaQRData(String qrString){
        LankaQRPayload lankaQRPayload = new LankaQRPayload();
        AdditionalData additionalData = null;
        UnrestrictedData unrestrictedData = null;

        try {
            System.out.println("QR STRING IS : " + qrString);

            PushPaymentData qrdata = parseQRCode(qrString);
            System.out.println("QR DATA IS : " + qrdata);
            try {
                additionalData = qrdata.getAdditionalData();

                lankaQRPayload.setMerchantCategoryCode(qrdata.getMerchantCategoryCode());

                lankaQRPayload.setPointOfInitiationMethod(qrdata.getPointOfInitiationMethod());

                if (additionalData != null) {
                    try {
                        lankaQRPayload.setReferenceId(additionalData.getReferenceId() != null || additionalData.getReferenceId().equals("***") ? additionalData.getReferenceId() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-1");
                    }
                    try {
                        lankaQRPayload.setBillNumber(additionalData.getBillNumber() != null ? additionalData.getBillNumber() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-2");
                    }
                    try {
                        lankaQRPayload.setConsumerId(additionalData.getConsumerId() != null ? additionalData.getConsumerId() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-3");
                    }
                    try {
                        lankaQRPayload.setMobileNumber(additionalData.getMobileNumber() != null ? additionalData.getMobileNumber() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-4");
                    }
                    try {
                        lankaQRPayload.setPurpose(additionalData.getPurpose() != null ? additionalData.getPurpose() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-5");
                    }
                    try {
                        lankaQRPayload.setStoreId(additionalData.getStoreId() != null ? additionalData.getStoreId() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-6");
                    }
                    try {
                        lankaQRPayload.setLoyaltyNumber(additionalData.getLoyaltyNumber() != null ? additionalData.getLoyaltyNumber() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-7");
                    }
                    try {
                        lankaQRPayload.setTerminalId(additionalData.getTerminalId() != null ? additionalData.getTerminalId() : "");
                    } catch (Exception e) {
                        System.out.println(e + "#####################-8");
                    }
                }
            } catch (Exception e) {
                System.out.println(e + "#####################-9");
            }
            try {
                lankaQRPayload.setTransactionFee(qrdata.getTransactionAmount().toString());
            } catch (Exception e) {
                System.out.println(e + "#####################-10");
            }
            try {
                lankaQRPayload.setMerchantCity(qrdata.getMerchantCity() != null ? qrdata.getMerchantCity() : "");
            } catch (Exception e) {
                System.out.println(e + "#####################-11");
            }
            try {
                lankaQRPayload.setMerchantName(qrdata.getMerchantName() != null ? qrdata.getMerchantName() : "");
            } catch (Exception e) {
                System.out.println(e + "#####################-12");
            }
            try {
                lankaQRPayload.setTipOrConFeeIndicator(qrdata.getTipOrConvenienceIndicator() != null ? qrdata.getTipOrConvenienceIndicator() : "");
            } catch (Exception e) {
                System.out.println(e + "#####################-13");
            }
            try {
                lankaQRPayload.setConvenienceFee(qrdata.getValueOfConvenienceFeeFixed().toString());
            } catch (Exception e) {
                System.out.println(e + "#####################-14");
            }
            try {
                lankaQRPayload.setConveniencePercentage(qrdata.getValueOfConvenienceFeePercentage() != null ? qrdata.getValueOfConvenienceFeePercentage() : 0.0);
            } catch (Exception e) {
                System.out.println(e + "#####################-15");
            }
            try {
                lankaQRPayload.setQrMAIData(qrdata.getMAIData("26").getAID());
            } catch (Exception tag26error) {
                System.out.println(tag26error + "#####################-16");
                lankaQRPayload.setQrMAIData(qrdata.getMAIData("27").getAID());
            }

            try {
                unrestrictedData = qrdata.getUnrestrictedData("85");
                if (unrestrictedData != null) {
                    lankaQRPayload.setUnrestrictedTag85String(unrestrictedData.toString());
                }
            } catch (Exception e) {

                System.out.println(e + "#####################-17");
            }

            return new Gson().toJson(lankaQRPayload);
        } catch (Exception e) {

            System.out.println(e + "#####################-18");
            return LQRErrorCode;
        }
    }

    private static PushPaymentData parseQRCode(String code) {
        PushPaymentData qrcode = null;
        try {
            qrcode = Parser.parseWithoutTagValidation(code);
            qrcode.validate();
        } catch (Exception e) {
            System.out.println(e + "#####################-19");
        }
        return qrcode;
    }
}

