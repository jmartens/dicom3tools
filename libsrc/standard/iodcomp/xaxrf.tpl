CompositeIOD="XAImage"		Condition="XAImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="Synchronization"			Usage="U"	Condition="NeedToCheckModuleSynchronization"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="GeneralImage"				Usage="M"
		Module="GeneralReference"			Usage="U"	Condition="NeedModuleGeneralReference"
		Module="ImagePixel"					Usage="M"
		Module="ContrastBolus"				Usage="C"	Condition="NeedModuleContrastBolus"
		Module="Cine"						Usage="C"	Condition="NeedModuleCine"
		Module="MultiFrame"					Usage="C" 	Condition="NeedModuleMultiFrame"
		Module="FramePointers"				Usage="U"	Condition="NeedModuleFramePointers"
		Module="Mask"						Usage="C" 	Condition="NeedModuleMask"
		Module="DisplayShutter"				Usage="U"	Condition="NeedModuleDisplayShutter"
		Module="Device"						Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"				Usage="U"	Condition="NeedModuleIntervention"
		Module="Specimen"					Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRayImage"					Usage="M"
		Module="XRayAcquisition"			Usage="M"
		Module="XRayCollimator"				Usage="U"	Condition="NeedModuleXRayCollimator"
		Module="XRayTable"					Usage="C"	Condition="NeedModuleXRayTable"
		Module="XAPositioner"				Usage="M"
		Module="DXDetector"					Usage="U"	Condition="NeedModuleDXDetector"
		Module="OverlayPlane"				Usage="U"	Condition="NeedModuleOverlayPlane"
		Module="MultiFrameOverlay"			Usage="C" 	Condition="NeedModuleMultiFrameOverlay"
		Module="ModalityLUT"				Usage="C"	Condition="XRayNeedModuleModalityLUT"
		Module="VOILUT"						Usage="U"	Condition="NeedModuleVOILUT"
		Module="SOPCommon"					Usage="M"
		Module="CommonInstanceReference"	Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"			Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

CompositeIOD="XRFImage"		Condition="XRFImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="Synchronization"			Usage="U"	Condition="NeedToCheckModuleSynchronization"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="GeneralImage"				Usage="M"
		Module="GeneralReference"			Usage="U"	Condition="NeedModuleGeneralReference"
		Module="ImagePixel"					Usage="M"
		Module="ContrastBolus"				Usage="C"	Condition="NeedModuleContrastBolus"
		Module="Cine"						Usage="C"	Condition="NeedModuleCine"
		Module="MultiFrame"					Usage="C" 	Condition="NeedModuleMultiFrame"
		Module="FramePointers"				Usage="U"	Condition="NeedModuleFramePointers"
		Module="Mask"						Usage="C" 	Condition="NeedModuleMask"
		Module="XRayImage"					Usage="M"
		Module="XRayAcquisition"			Usage="M"
		Module="XRayCollimator"				Usage="U"	Condition="NeedModuleXRayCollimator"
		Module="DisplayShutter"				Usage="U"	Condition="NeedModuleDisplayShutter"
		Module="Device"						Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"				Usage="U"	Condition="NeedModuleIntervention"
		Module="Specimen"					Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRayTable"					Usage="C"	Condition="NeedModuleXRayTable"
		Module="XRFPositioner"				Usage="U"
		Module="XRayTomographyAcquisition"	Usage="U"	Condition="NeedModuleXRayTomographyAcquisitionBasedOnScanOptions"
		Module="DXDetector"					Usage="U"	Condition="NeedModuleDXDetector"
		Module="OverlayPlane"				Usage="U"	Condition="NeedModuleOverlayPlane"
		Module="MultiFrameOverlay"			Usage="C" 	Condition="NeedModuleMultiFrameOverlay"
		Module="ModalityLUT"				Usage="C"	Condition="XRayNeedModuleModalityLUT"
		Module="VOILUT"						Usage="U"	Condition="NeedModuleVOILUT"
		Module="SOPCommon"					Usage="M"
		Module="CommonInstanceReference"	Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"			Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

CompositeIOD="EnhancedXAImage"		Condition="EnhancedXAImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="XAXRFSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="FrameOfReference"			Usage="C"	Condition="CArmPositionerTabletopRelationshipIsYes"
		Module="Synchronization"			Usage="C"	Condition="CArmPositionerTabletopRelationshipIsYes"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
		Module="EnhancedGeneralEquipment"	Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="ImagePixel"							Usage="M"
		Module="EnhancedContrastBolus"				Usage="C"	Condition="NeedModuleEnhancedContrastBolus"
		Module="Mask"								Usage="U" 	Condition="NeedModuleMask"
		Module="Device"								Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"						Usage="U"	Condition="NeedModuleIntervention"
		Module="AcquisitionContext"					Usage="M"
		Module="MultiFrameFunctionalGroupsCommon"				Usage="M"
		Module="MultiFrameFunctionalGroupsForEnhancedXAImage"	Usage="M"
		Module="MultiFrameDimension"				Usage="U"	Condition="NeedModuleMultiFrameDimension"
		Module="CardiacSynchronization"				Usage="C"	Condition="NeedModuleCardiacSynchronization"
		Module="RespiratorySynchronization"			Usage="C"	Condition="NeedModuleRespiratorySynchronization"
		Module="Specimen"							Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRayFiltration"						Usage="U"	Condition="NeedModuleXRayFiltration"
		Module="XRayGrid"							Usage="U"	Condition="NeedModuleXRayGrid"
		Module="EnhancedXAXRFImage"					Usage="M"
		Module="XAXRFAcquisition"					Usage="C"	Condition="ImageTypeValue1Original"
		Module="XRayImageIntensifier"				Usage="C"	Condition="XRayReceptorTypeIsImageIntensifier"
		Module="XRayDetector"						Usage="C"	Condition="XRayReceptorTypeIsDigitalDetector"
		Module="XAXRFMultiFramePresentation"		Usage="U"	Condition="NeedModuleXAXRFMultiFramePresentation"
		Module="SOPCommon"							Usage="M"
		Module="CommonInstanceReference"			Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"					Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

CompositeIOD="EnhancedXRFImage"		Condition="EnhancedXRFImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="XAXRFSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="FrameOfReference"			Usage="U"	Condition="NeedModuleFrameOfReference"
		Module="Synchronization"			Usage="U"	Condition="NeedToCheckModuleSynchronization"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
		Module="EnhancedGeneralEquipment"	Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="ImagePixel"							Usage="M"
		Module="EnhancedContrastBolus"				Usage="C"	Condition="NeedModuleEnhancedContrastBolus"
		Module="Mask"								Usage="U" 	Condition="NeedModuleMask"
		Module="Device"								Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"						Usage="U"	Condition="NeedModuleIntervention"
		Module="AcquisitionContext"					Usage="M"
		Module="MultiFrameFunctionalGroupsCommon"				Usage="M"
		Module="MultiFrameFunctionalGroupsForEnhancedXRFImage"	Usage="M"
		Module="MultiFrameDimension"				Usage="U"	Condition="NeedModuleMultiFrameDimension"
		Module="CardiacSynchronization"				Usage="C"	Condition="NeedModuleCardiacSynchronization"
		Module="RespiratorySynchronization"			Usage="C"	Condition="NeedModuleRespiratorySynchronization"
		Module="Specimen"							Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRayTomographyAcquisition"			Usage="U"	Condition="NeedToCheckModuleXRayTomographyAcquisition"
		Module="XRayFiltration"						Usage="U"	Condition="NeedModuleXRayFiltration"
		Module="XRayGrid"							Usage="U"	Condition="NeedModuleXRayGrid"
		Module="EnhancedXAXRFImage"					Usage="M"
		Module="XAXRFAcquisition"					Usage="C"	Condition="ImageTypeValue1Original"
		Module="XRayImageIntensifier"				Usage="C"	Condition="XRayReceptorTypeIsImageIntensifier"
		Module="XRayDetector"						Usage="C"	Condition="XRayReceptorTypeIsDigitalDetector"
		Module="XAXRFMultiFramePresentation"		Usage="U"	Condition="NeedModuleXAXRFMultiFramePresentation"
		Module="SOPCommon"							Usage="M"
		Module="CommonInstanceReference"			Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"					Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

CompositeIOD="XRay3DAngiographicImage"		Condition="XRay3DAngiographicImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
		Module="EnhancedSeries"				Usage="M"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="FrameOfReference"			Usage="M"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
		Module="EnhancedGeneralEquipment"	Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="ImagePixel"												Usage="M"
		Module="EnhancedContrastBolus"									Usage="C"	Condition="NeedModuleEnhancedContrastBolus"
		Module="Device"													Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"											Usage="U"	Condition="NeedModuleIntervention"
		Module="AcquisitionContext"										Usage="M"
		Module="MultiFrameFunctionalGroupsCommon"						Usage="M"
		Module="MultiFrameFunctionalGroupsForXRay3DAngiographicImage"	Usage="M"
		Module="MultiFrameDimension"									Usage="U"	Condition="NeedModuleMultiFrameDimension"
		Module="CardiacSynchronization"									Usage="C"	Condition="NeedModuleCardiacSynchronization"
		Module="RespiratorySynchronization"								Usage="C"	Condition="NeedModuleRespiratorySynchronization"
		Module="PatientOrientation"										Usage="U"	Condition="NeedModulePatientOrientation"
		Module="ImageEquipmentCoordinateRelationship"					Usage="U"	Condition="NeedModuleImageEquipmentCoordinateRelationship"
		Module="Specimen"												Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRay3DImage"											Usage="M"
		Module="XRay3DAngiographicImageContributingSources"				Usage="U"	Condition="NeedModuleXRay3DAngiographicImageContributingSources"
		Module="XRay3DAngiographicAcquisition"							Usage="U"	Condition="NeedModuleXRay3DAngiographicAcquisition"
		Module="XRay3DReconstruction"									Usage="U"	Condition="NeedModuleXRay3DReconstruction"
		Module="SOPCommon"												Usage="M"
		Module="CommonInstanceReference"								Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"										Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

CompositeIOD="XRay3DCraniofacialImage"		Condition="XRay3DCraniofacialImageInstance"
	InformationEntity="File"
		Module="FileMetaInformation"		Usage="C"	Condition="NeedModuleFileMetaInformation"
	InformationEntityEnd
	InformationEntity="Patient"
		Module="Patient"					Usage="M"
		Module="ClinicalTrialSubject"		Usage="U"	Condition="NeedModuleClinicalTrialSubject"
	InformationEntityEnd
	InformationEntity="Study"
		Module="GeneralStudy"				Usage="M"
		Module="PatientStudy"				Usage="U"
		Module="ClinicalTrialStudy"			Usage="U"	Condition="NeedModuleClinicalTrialStudy"
	InformationEntityEnd
	InformationEntity="Series"
		Module="GeneralSeries"				Usage="M"
		Module="ClinicalTrialSeries"		Usage="U"	Condition="NeedModuleClinicalTrialSeries"
		Module="EnhancedSeries"				Usage="M"
	InformationEntityEnd
	InformationEntity="FrameOfReference"
		Module="FrameOfReference"			Usage="M"
	InformationEntityEnd
	InformationEntity="Equipment"
		Module="GeneralEquipment"			Usage="M"
		Module="EnhancedGeneralEquipment"	Usage="M"
	InformationEntityEnd
	InformationEntity="Image"
		Module="ImagePixel"												Usage="M"
		Module="EnhancedContrastBolus"									Usage="C"	Condition="NeedModuleEnhancedContrastBolus"
		Module="Device"													Usage="U"	Condition="NeedModuleDevice"
		Module="Intervention"											Usage="U"	Condition="NeedModuleIntervention"
		Module="AcquisitionContext"										Usage="M"
		Module="MultiFrameFunctionalGroupsCommon"						Usage="M"
		Module="MultiFrameFunctionalGroupsForXRay3DCraniofacialImage"	Usage="M"
		Module="MultiFrameDimension"									Usage="U"	Condition="NeedModuleMultiFrameDimension"
		Module="PatientOrientation"										Usage="U"	Condition="NeedModulePatientOrientation"
		Module="ImageEquipmentCoordinateRelationship"					Usage="U"	Condition="NeedModuleImageEquipmentCoordinateRelationship"
		Module="Specimen"												Usage="U"	Condition="NeedModuleSpecimen"
		Module="XRay3DImage"											Usage="M"
		Module="XRay3DCraniofacialImageContributingSources"				Usage="U"	Condition="NeedModuleXRay3DCraniofacialImageContributingSources"
		Module="XRay3DCraniofacialAcquisition"							Usage="U"	Condition="NeedModuleXRay3DCraniofacialAcquisition"
		Module="XRay3DReconstruction"									Usage="U"	Condition="NeedModuleXRay3DReconstruction"
		Module="SOPCommon"												Usage="M"
		Module="CommonInstanceReference"								Usage="U"	Condition="NeedModuleCommonInstanceReference"
		Module="FrameExtraction"										Usage="C"	Condition="NeedModuleFrameExtraction"
	InformationEntityEnd
CompositeIODEnd

