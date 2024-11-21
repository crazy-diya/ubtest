package justpay;

import com.google.gson.annotations.SerializedName;

public class LankaQRPayload {
    @SerializedName("qrMAIData")
    private String qrMAIData;
    @SerializedName("referenceId")
    private String referenceId;
    @SerializedName("transactionFee")
    private String transactionFee;
    @SerializedName("convenienceFee")
    private String convenienceFee;
    @SerializedName("conveniencePercentage")
    private double conveniencePercentage;
    @SerializedName("tipOrConFeeIndicator")
    private String tipOrConFeeIndicator;
    @SerializedName("merchantName")
    private String merchantName;
    @SerializedName("merchantCity")
    private String merchantCity;
    @SerializedName("terminalId")
    private String terminalId;
    @SerializedName("billNumber")
    private String billNumber;
    @SerializedName("mobileNumber")
    private String mobileNumber;
    @SerializedName("storeId")
    private String storeId;
    @SerializedName("loyaltyNumber")
    private String loyaltyNumber;
    @SerializedName("unrestrictedTag85String")
    private String unrestrictedTag85String;
    @SerializedName("pointOfInitiationMethod")
    private String pointOfInitiationMethod;
    @SerializedName("merchantCategoryCode")
    private String merchantCategoryCode;
    @SerializedName("consumerId")
    private String consumerId;
    @SerializedName("purpose")
    private String purpose;

    public String getQrMAIData() {
        return qrMAIData;
    }

    public void setQrMAIData(String qrMAIData) {
        this.qrMAIData = qrMAIData;
    }

    public String getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(String referenceId) {
        this.referenceId = referenceId;
    }

    public String getTransactionFee() {
        return transactionFee;
    }

    public void setTransactionFee(String transactionFee) {
        this.transactionFee = transactionFee;
    }

    public String getConvenienceFee() {
        return convenienceFee;
    }

    public void setConvenienceFee(String convenienceFee) {
        this.convenienceFee = convenienceFee;
    }

    public double getConveniencePercentage() {
        return conveniencePercentage;
    }

    public void setConveniencePercentage(double conveniencePercentage) {
        this.conveniencePercentage = conveniencePercentage;
    }

    public String getTipOrConFeeIndicator() {
        return tipOrConFeeIndicator;
    }

    public void setTipOrConFeeIndicator(String tipOrConFeeIndicator) {
        this.tipOrConFeeIndicator = tipOrConFeeIndicator;
    }

    public String getMerchantName() {
        return merchantName;
    }

    public void setMerchantName(String merchantName) {
        this.merchantName = merchantName;
    }

    public String getMerchantCity() {
        return merchantCity;
    }

    public void setMerchantCity(String merchantCity) {
        this.merchantCity = merchantCity;
    }

    public String getTerminalId() {
        return terminalId;
    }

    public void setTerminalId(String terminalId) {
        this.terminalId = terminalId;
    }

    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    public String getLoyaltyNumber() {
        return loyaltyNumber;
    }

    public void setLoyaltyNumber(String loyaltyNumber) {
        this.loyaltyNumber = loyaltyNumber;
    }

    public String getUnrestrictedTag85String() {
        return unrestrictedTag85String;
    }

    public void setUnrestrictedTag85String(String unrestrictedTag85String) {
        this.unrestrictedTag85String = unrestrictedTag85String;
    }

    public String getPointOfInitiationMethod() {
        return pointOfInitiationMethod;
    }

    public void setPointOfInitiationMethod(String pointOfInitiationMethod) {
        this.pointOfInitiationMethod = pointOfInitiationMethod;
    }

    public String getMerchantCategoryCode() {
        return merchantCategoryCode;
    }

    public void setMerchantCategoryCode(String merchantCategoryCode) {
        this.merchantCategoryCode = merchantCategoryCode;
    }

    public String getConsumerId() {
        return consumerId;
    }

    public void setConsumerId(String consumerId) {
        this.consumerId = consumerId;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }
}
