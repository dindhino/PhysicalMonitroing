﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34209
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Biofarma.Service.ERP.MasterItemERP {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="CallContext", Namespace="http://schemas.microsoft.com/dynamics/2010/01/datacontracts")]
    [System.SerializableAttribute()]
    public partial class CallContext : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CompanyField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string LanguageField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string LogonAsUserField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MessageIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string PartitionKeyField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private System.Collections.Generic.Dictionary<string, string> PropertyBagField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Company {
            get {
                return this.CompanyField;
            }
            set {
                if ((object.ReferenceEquals(this.CompanyField, value) != true)) {
                    this.CompanyField = value;
                    this.RaisePropertyChanged("Company");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Language {
            get {
                return this.LanguageField;
            }
            set {
                if ((object.ReferenceEquals(this.LanguageField, value) != true)) {
                    this.LanguageField = value;
                    this.RaisePropertyChanged("Language");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string LogonAsUser {
            get {
                return this.LogonAsUserField;
            }
            set {
                if ((object.ReferenceEquals(this.LogonAsUserField, value) != true)) {
                    this.LogonAsUserField = value;
                    this.RaisePropertyChanged("LogonAsUser");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string MessageId {
            get {
                return this.MessageIdField;
            }
            set {
                if ((object.ReferenceEquals(this.MessageIdField, value) != true)) {
                    this.MessageIdField = value;
                    this.RaisePropertyChanged("MessageId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string PartitionKey {
            get {
                return this.PartitionKeyField;
            }
            set {
                if ((object.ReferenceEquals(this.PartitionKeyField, value) != true)) {
                    this.PartitionKeyField = value;
                    this.RaisePropertyChanged("PartitionKey");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public System.Collections.Generic.Dictionary<string, string> PropertyBag {
            get {
                return this.PropertyBagField;
            }
            set {
                if ((object.ReferenceEquals(this.PropertyBagField, value) != true)) {
                    this.PropertyBagField = value;
                    this.RaisePropertyChanged("PropertyBag");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="SCC_WSItemObj", Namespace="http://schemas.datacontract.org/2004/07/Dynamics.Ax.Application")]
    [System.SerializableAttribute()]
    public partial class SCC_WSItemObj : Biofarma.Service.ERP.MasterItemERP.XppObjectBase {
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ItemIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ItemNameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal PriceInventField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal PricePurchField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private decimal PriceSalesField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StyleIdField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StyleNameField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string UnitInventField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string UnitPurchField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string UnitSalesField;
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ItemId {
            get {
                return this.ItemIdField;
            }
            set {
                if ((object.ReferenceEquals(this.ItemIdField, value) != true)) {
                    this.ItemIdField = value;
                    this.RaisePropertyChanged("ItemId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ItemName {
            get {
                return this.ItemNameField;
            }
            set {
                if ((object.ReferenceEquals(this.ItemNameField, value) != true)) {
                    this.ItemNameField = value;
                    this.RaisePropertyChanged("ItemName");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal PriceInvent {
            get {
                return this.PriceInventField;
            }
            set {
                if ((this.PriceInventField.Equals(value) != true)) {
                    this.PriceInventField = value;
                    this.RaisePropertyChanged("PriceInvent");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal PricePurch {
            get {
                return this.PricePurchField;
            }
            set {
                if ((this.PricePurchField.Equals(value) != true)) {
                    this.PricePurchField = value;
                    this.RaisePropertyChanged("PricePurch");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public decimal PriceSales {
            get {
                return this.PriceSalesField;
            }
            set {
                if ((this.PriceSalesField.Equals(value) != true)) {
                    this.PriceSalesField = value;
                    this.RaisePropertyChanged("PriceSales");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StyleId {
            get {
                return this.StyleIdField;
            }
            set {
                if ((object.ReferenceEquals(this.StyleIdField, value) != true)) {
                    this.StyleIdField = value;
                    this.RaisePropertyChanged("StyleId");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StyleName {
            get {
                return this.StyleNameField;
            }
            set {
                if ((object.ReferenceEquals(this.StyleNameField, value) != true)) {
                    this.StyleNameField = value;
                    this.RaisePropertyChanged("StyleName");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string UnitInvent {
            get {
                return this.UnitInventField;
            }
            set {
                if ((object.ReferenceEquals(this.UnitInventField, value) != true)) {
                    this.UnitInventField = value;
                    this.RaisePropertyChanged("UnitInvent");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string UnitPurch {
            get {
                return this.UnitPurchField;
            }
            set {
                if ((object.ReferenceEquals(this.UnitPurchField, value) != true)) {
                    this.UnitPurchField = value;
                    this.RaisePropertyChanged("UnitPurch");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string UnitSales {
            get {
                return this.UnitSalesField;
            }
            set {
                if ((object.ReferenceEquals(this.UnitSalesField, value) != true)) {
                    this.UnitSalesField = value;
                    this.RaisePropertyChanged("UnitSales");
                }
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="XppObjectBase", Namespace="http://schemas.datacontract.org/2004/07/Microsoft.Dynamics.Ax.Xpp")]
    [System.SerializableAttribute()]
    [System.Runtime.Serialization.KnownTypeAttribute(typeof(Biofarma.Service.ERP.MasterItemERP.SCC_WSItemObj))]
    public partial class XppObjectBase : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="AifFault", Namespace="http://schemas.microsoft.com/dynamics/2008/01/documents/Fault")]
    [System.SerializableAttribute()]
    public partial class AifFault : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CustomDetailXmlField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Biofarma.Service.ERP.MasterItemERP.FaultMessageList[] FaultMessageListArrayField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Biofarma.Service.ERP.MasterItemERP.InfologMessage[] InfologMessageListField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string StackTraceField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private int XppExceptionTypeField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string CustomDetailXml {
            get {
                return this.CustomDetailXmlField;
            }
            set {
                if ((object.ReferenceEquals(this.CustomDetailXmlField, value) != true)) {
                    this.CustomDetailXmlField = value;
                    this.RaisePropertyChanged("CustomDetailXml");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Biofarma.Service.ERP.MasterItemERP.FaultMessageList[] FaultMessageListArray {
            get {
                return this.FaultMessageListArrayField;
            }
            set {
                if ((object.ReferenceEquals(this.FaultMessageListArrayField, value) != true)) {
                    this.FaultMessageListArrayField = value;
                    this.RaisePropertyChanged("FaultMessageListArray");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Biofarma.Service.ERP.MasterItemERP.InfologMessage[] InfologMessageList {
            get {
                return this.InfologMessageListField;
            }
            set {
                if ((object.ReferenceEquals(this.InfologMessageListField, value) != true)) {
                    this.InfologMessageListField = value;
                    this.RaisePropertyChanged("InfologMessageList");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string StackTrace {
            get {
                return this.StackTraceField;
            }
            set {
                if ((object.ReferenceEquals(this.StackTraceField, value) != true)) {
                    this.StackTraceField = value;
                    this.RaisePropertyChanged("StackTrace");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public int XppExceptionType {
            get {
                return this.XppExceptionTypeField;
            }
            set {
                if ((this.XppExceptionTypeField.Equals(value) != true)) {
                    this.XppExceptionTypeField = value;
                    this.RaisePropertyChanged("XppExceptionType");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="FaultMessageList", Namespace="http://schemas.microsoft.com/dynamics/2008/01/documents/Fault")]
    [System.SerializableAttribute()]
    public partial class FaultMessageList : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string DocumentField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string DocumentOperationField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Biofarma.Service.ERP.MasterItemERP.FaultMessage[] FaultMessageArrayField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string FieldField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ServiceField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ServiceOperationField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string ServiceOperationParameterField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string XPathField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string XmlLineField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string XmlPositionField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Document {
            get {
                return this.DocumentField;
            }
            set {
                if ((object.ReferenceEquals(this.DocumentField, value) != true)) {
                    this.DocumentField = value;
                    this.RaisePropertyChanged("Document");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string DocumentOperation {
            get {
                return this.DocumentOperationField;
            }
            set {
                if ((object.ReferenceEquals(this.DocumentOperationField, value) != true)) {
                    this.DocumentOperationField = value;
                    this.RaisePropertyChanged("DocumentOperation");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Biofarma.Service.ERP.MasterItemERP.FaultMessage[] FaultMessageArray {
            get {
                return this.FaultMessageArrayField;
            }
            set {
                if ((object.ReferenceEquals(this.FaultMessageArrayField, value) != true)) {
                    this.FaultMessageArrayField = value;
                    this.RaisePropertyChanged("FaultMessageArray");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Field {
            get {
                return this.FieldField;
            }
            set {
                if ((object.ReferenceEquals(this.FieldField, value) != true)) {
                    this.FieldField = value;
                    this.RaisePropertyChanged("Field");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Service {
            get {
                return this.ServiceField;
            }
            set {
                if ((object.ReferenceEquals(this.ServiceField, value) != true)) {
                    this.ServiceField = value;
                    this.RaisePropertyChanged("Service");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ServiceOperation {
            get {
                return this.ServiceOperationField;
            }
            set {
                if ((object.ReferenceEquals(this.ServiceOperationField, value) != true)) {
                    this.ServiceOperationField = value;
                    this.RaisePropertyChanged("ServiceOperation");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string ServiceOperationParameter {
            get {
                return this.ServiceOperationParameterField;
            }
            set {
                if ((object.ReferenceEquals(this.ServiceOperationParameterField, value) != true)) {
                    this.ServiceOperationParameterField = value;
                    this.RaisePropertyChanged("ServiceOperationParameter");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string XPath {
            get {
                return this.XPathField;
            }
            set {
                if ((object.ReferenceEquals(this.XPathField, value) != true)) {
                    this.XPathField = value;
                    this.RaisePropertyChanged("XPath");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string XmlLine {
            get {
                return this.XmlLineField;
            }
            set {
                if ((object.ReferenceEquals(this.XmlLineField, value) != true)) {
                    this.XmlLineField = value;
                    this.RaisePropertyChanged("XmlLine");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string XmlPosition {
            get {
                return this.XmlPositionField;
            }
            set {
                if ((object.ReferenceEquals(this.XmlPositionField, value) != true)) {
                    this.XmlPositionField = value;
                    this.RaisePropertyChanged("XmlPosition");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="InfologMessage", Namespace="http://schemas.datacontract.org/2004/07/Microsoft.Dynamics.AX.Framework.Services")]
    [System.SerializableAttribute()]
    public partial class InfologMessage : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private Biofarma.Service.ERP.MasterItemERP.InfologMessageType InfologMessageTypeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MessageField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public Biofarma.Service.ERP.MasterItemERP.InfologMessageType InfologMessageType {
            get {
                return this.InfologMessageTypeField;
            }
            set {
                if ((this.InfologMessageTypeField.Equals(value) != true)) {
                    this.InfologMessageTypeField = value;
                    this.RaisePropertyChanged("InfologMessageType");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Message {
            get {
                return this.MessageField;
            }
            set {
                if ((object.ReferenceEquals(this.MessageField, value) != true)) {
                    this.MessageField = value;
                    this.RaisePropertyChanged("Message");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="FaultMessage", Namespace="http://schemas.microsoft.com/dynamics/2008/01/documents/Fault")]
    [System.SerializableAttribute()]
    public partial class FaultMessage : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string CodeField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string MessageField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Code {
            get {
                return this.CodeField;
            }
            set {
                if ((object.ReferenceEquals(this.CodeField, value) != true)) {
                    this.CodeField = value;
                    this.RaisePropertyChanged("Code");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Message {
            get {
                return this.MessageField;
            }
            set {
                if ((object.ReferenceEquals(this.MessageField, value) != true)) {
                    this.MessageField = value;
                    this.RaisePropertyChanged("Message");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="InfologMessageType", Namespace="http://schemas.datacontract.org/2004/07/Microsoft.Dynamics.AX.Framework.Services")]
    public enum InfologMessageType : int {
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        Info = 0,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        Warning = 1,
        
        [System.Runtime.Serialization.EnumMemberAttribute()]
        Error = 2,
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(Namespace="http://tempuri.org", ConfigurationName="MasterItemERP.SCC_WSProduct")]
    public interface SCC_WSProduct {
        
        // CODEGEN: Generating message contract since the wrapper name (SCC_WSProductGetAllItemRequest) of message SCC_WSProductGetAllItemRequest does not match the default value (getAllItem)
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/SCC_WSProduct/getAllItem", ReplyAction="http://tempuri.org/SCC_WSProduct/getAllItemResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(Biofarma.Service.ERP.MasterItemERP.AifFault), Action="http://tempuri.org/SCC_WSProduct/getAllItemAifFaultFault", Name="AifFault", Namespace="http://schemas.microsoft.com/dynamics/2008/01/documents/Fault")]
        Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemResponse getAllItem(Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemRequest request);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(WrapperName="SCC_WSProductGetAllItemRequest", WrapperNamespace="http://tempuri.org", IsWrapped=true)]
    public partial class SCC_WSProductGetAllItemRequest {
        
        [System.ServiceModel.MessageHeaderAttribute(Namespace="http://schemas.microsoft.com/dynamics/2010/01/datacontracts")]
        public Biofarma.Service.ERP.MasterItemERP.CallContext CallContext;
        
        public SCC_WSProductGetAllItemRequest() {
        }
        
        public SCC_WSProductGetAllItemRequest(Biofarma.Service.ERP.MasterItemERP.CallContext CallContext) {
            this.CallContext = CallContext;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(WrapperName="SCC_WSProductGetAllItemResponse", WrapperNamespace="http://tempuri.org", IsWrapped=true)]
    public partial class SCC_WSProductGetAllItemResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://tempuri.org", Order=0)]
        public Biofarma.Service.ERP.MasterItemERP.SCC_WSItemObj[] response;
        
        public SCC_WSProductGetAllItemResponse() {
        }
        
        public SCC_WSProductGetAllItemResponse(Biofarma.Service.ERP.MasterItemERP.SCC_WSItemObj[] response) {
            this.response = response;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface SCC_WSProductChannel : Biofarma.Service.ERP.MasterItemERP.SCC_WSProduct, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class SCC_WSProductClient : System.ServiceModel.ClientBase<Biofarma.Service.ERP.MasterItemERP.SCC_WSProduct>, Biofarma.Service.ERP.MasterItemERP.SCC_WSProduct {
        
        public SCC_WSProductClient() {
        }
        
        public SCC_WSProductClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public SCC_WSProductClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SCC_WSProductClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SCC_WSProductClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemResponse Biofarma.Service.ERP.MasterItemERP.SCC_WSProduct.getAllItem(Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemRequest request) {
            return base.Channel.getAllItem(request);
        }
        
        public Biofarma.Service.ERP.MasterItemERP.SCC_WSItemObj[] getAllItem(Biofarma.Service.ERP.MasterItemERP.CallContext CallContext) {
            Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemRequest inValue = new Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemRequest();
            inValue.CallContext = CallContext;
            Biofarma.Service.ERP.MasterItemERP.SCC_WSProductGetAllItemResponse retVal = ((Biofarma.Service.ERP.MasterItemERP.SCC_WSProduct)(this)).getAllItem(inValue);
            return retVal.response;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(Namespace="http://schemas.microsoft.com/netfx/2009/05/routing", ConfigurationName="MasterItemERP.IRequestReplyRouter")]
    public interface IRequestReplyRouter {
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IRequestReplyRouterChannel : Biofarma.Service.ERP.MasterItemERP.IRequestReplyRouter, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class RequestReplyRouterClient : System.ServiceModel.ClientBase<Biofarma.Service.ERP.MasterItemERP.IRequestReplyRouter>, Biofarma.Service.ERP.MasterItemERP.IRequestReplyRouter {
        
        public RequestReplyRouterClient() {
        }
        
        public RequestReplyRouterClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public RequestReplyRouterClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RequestReplyRouterClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RequestReplyRouterClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
    }
}