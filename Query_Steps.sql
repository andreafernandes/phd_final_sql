-----------------------------------------
--1
-----------------------------------------
-- CORE TABLE
-- patients with referral between jan08 - dec16 and 
-- have f2f contact within 6 months of date of referral
-----------------------------------------
--SELECT * 

--INTO SQLCRIS_User.dbo.CoreTable15092017

--from
--				(
--							SELECT 
--										--Distinct 
--										(Referral.BrcId),
--										Accepted_Date as Referral_accepted_date,
--										Discharge_Date as Referral_end_date,
--										Spell,
--										Event.Start_Date,
--										Event_Type_Of_Contact_ID
									
--							FROM 
--										SQLCRIS.dbo.Referral

--							INNER JOIN 	
--										Event

--							on 			
--										Event.brcid = Referral.brcid

--							WHERE 
--										(
--										Accepted_Date BETWEEN '01-JAN-2008' and '31-DEC-2016'
--										AND
--											(
--											(Event.Event_Type_Of_Contact_ID LIKE '%face%')
--											AND 
--											Event.Start_Date < (DATEADD(mm, 6, Accepted_Date)) 
--											AND
--											Event.Start_Date > (Accepted_Date)
--											)
--										) 
--				) CoreCohort

---------
-- CHECKS - no patient row in this table should have had a f2f event note type within 6 months of patient referral date. 
---------
--SELECT * 

--FROM SQLCRIS_User.dbo.AfernandesCoreCohort15092017

--WHERE DATEDIFF(DD, Referral_start_date, Start_date) > 183 --(183 = definition of 6 months)

-- query returns 0 patients, so meets the criteria

------------------------------------------
-- MAKE A TABLE OF CORE TABLE (Table name: SQLCRIS_User.dbo.CoreTable21092017, N = (xxxxx row(s) affected))



---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------
----3
-------------------------------------------
---- CREATING ANTIDEPRESSANT MEDICATION TABLE 
---- (which will include a column with the generic antidepressant name)
-------------------------------------------
--SELECT * 

--INTO SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017

--FROM

--(

--SELECT 						
--							SQLCrisImport.dbo.medication_combined.drug,
--(
--													CASE 
--														   WHEN drug like '%lithium%' 
--															 or drug like '%camcolit%'  
--															 or drug like '%liskonum%' 
--															 or drug like '%priadel%' 
--															 or drug like '%li-liquid%' 
--														   THEN 'LITHIUM'
														   

--														   WHEN drug like '%amitriptyline%' 
--															 or drug like '%vanatrip%' --frOM drugs.COm
--															 or drug like '%elavil%'   --frOM drugs.COm
--															 or drug like '%endep%'    --frOM drugs.COm
--															 or DRuG LIKE '%triptaf%'  --COnTAInS AMItRIpTyLINe AnD PErPHEnAZInE
--														   THEN 'TCA_AMITRIPTYLINE'
														   
--														   WHEN drug like '%clomipramin%' 
--															 or drug like '%anafranil%' 
--														   THEN 'TCA_Clomipramine'
														   
--														   WHEN drug like '%dosulepin%' 
--															 or drug like '%dothiepin%' --PreViOuSLy KnoWN As DoTHIEPIN
--															 or drug like '%prothiden%' 
--															 or drug like '%prothiaden%' 
--														   THEN 'TCA_Dosulepin'
														     
--														   WHEN drug like '%doxepin%' 
--															 or drug like '%sinepin%' 
--															 or drug like '%sineq%'  --FroM drug.SCOm
--															-- or drug like '%xepin%' --FRom DRUGS.CoM ---picks up type of SSRI Mirtazapine
--														   THEN 'TCA_Doxepin'
														     
--														   WHEN drug like '%imipramine%' 
--															 or drug like '%tofranil%' -- FroM DrUGS.coM
--														   THEN 'TCA_Imipramine'  
														     
--														   WHEN drug like '%lofepramine%' 
--															 or drug like '%lomont%'
--														   THEN 'TCA_Lofepramine'
																
--														   WHEN drug like '%nortriptyli%' 
--															 or drug like '%pamelo%'
--															 or drug like '%allegr%' 
--															 or drug like '%aventyl%'
--														   THEN 'TCA_Nortriptylin'
														   
--														   WHEN drug like '%trimipram%' 
--															 or drug like '%surmonti%' 
--														   THEN 'TCA_Trimipramine'
													       
--														   WHEN drug like '%mianserin%' 
--														   THEN 'TCArelated_Mianserin'
													       
--														   WHEN drug like '%trazodone%' 
--															 or drug like '%molipaxin%' 
--														   THEN 'TCArelated_Trazodone'
													       
--														   WHEN drug like '%phenelzine%' 
--															 or drug like '%phenylethylhydrazine%'
--															-- or drug like '%alazin%' picks up non-AD drugs
--															 or drug like '%nardil%' 
--														   THEN 'MAOI_Phenelzine'
													       
--														   WHEN drug like '%isocarboxazid%' 
--														   THEN 'MAOI_Isocarboxazid'
													       
--														   WHEN drug like '%tranylcypromin%' 
--															 or drug like '%parnate%'
--														   THEN 'MAOI_Tranylcypromine'

--														   WHEN drug like '%moclobemide%' 
--															 or drug like '%manerix%' 
--														   THEN 'REVERSEMAOI_Moclobemide'
													       
--														   WHEN Drug like 'citalopram%' 
--															 or drug like '%cipramil%' 
--															 or drug like '%celexa%' 
--														   THEN 'SSRI_Citalopram'
													         
--														   WHEN drug like '%escitalopram%' 
--															 or drug like '%cipralex%'
--															 or drug like '%lexapro%'
--														   THEN 'SSRI_Escitalopram' 
													         
--														   WHEN drug like '%fluoxetine%' 
--															 or drug like '%prozac%' 
--															 or drug like '%sarafem%'
--															 or drug like '%bellzac%' --from drugs.com; used in Ireland
--															 or drug like '%oxactin%' --from drugs.com; drug company: Discovery
--														   THEN 'SSRI_Fluoxetine'
													       
--														   WHEN drug like '%fluvoxamine%' 
--															 or drug like '%faverin%' 
--														   THEN 'SSRI_Fluvoxamine'
														   
--														   WHEN drug like'%paroxetin%' 
--															 or drug like '%paxil%' --from drugs.com; not specified for UK use but used in US
--															 or drug like '%seroxat%' 
--														   THEN 'SSRI_Paroxetine'
														   
--														   WHEN drug like '%sertra%' 
--															 or drug like '%bellsert%' --from drugs.com; used in Ireland
--															 or drug like '%lustral%' 
--															 or drug like '%seretra%' --from drugs.com; used in Ireland   
--															 or drug like '%zoloft%'  -- from drugs.come; not specified for UK but used in US
--														   THEN 'SSRIs_Sertraline'
													 
--														   WHEN drug like '%mirtazapin%' 
--															 or drug like '%mirtazepin%' 
--															 or drug like '%zispin%' 
--															 or drug like '%mirza%'
--															 or drug like '%mirtaxepin%'
--														   THEN 'OTHERAD_Mirtazapin'
													       
--														   WHEN  drug like '%reboxet%' 
--															  or drug like '%reboxat%'
--															  or drug like '%edronax%'
--														   THEN 'SNRI_Reboxetin'
													       
--														   WHEN  drug like '%venlafaxine%' 
--															  or drug like '%effexor%'
--															  or drug like '%efexor%'
--														   THEN 'OTHERAD_Venlafaxine'
													       
--														   WHEN drug like '%agomelatin%' 
--															 or drug like '%valdoxan%' 
--														   THEN 'OTHERAD_Agomelatin'
													       
--														   WHEN  drug like '%duloxetin%'
--															  or drug like '%duloxatin%' 
--															  or drug like '%cymbalta%' 
--															  or drug like '%yentreve%' 
--														   THEN 'SNRI_Duloxetin'
													       
--														  -- REMOVED THIS AS ROB AND RINA SUGGESTED AFTER SUPERVISION 15122015
--														  -- WHEN drug like '%flupentixol%' 
--															 --or drug like '%fluanxol%' 
--															 --or drug like '%depixol%' 
--														  -- THEN 'SNRI_Flupentixol'
														   
--														   WHEN drug like '%tryptophan%' 
--															 or drug like '%optimax%' 
--														   THEN 'OTHERAD_Tryptophan'
														   
--														   WHEN drug like '%bupropio%'
--														   THEN 'OTHERAD_Bupropion'
														   
--													end 
--													) as generic_ad_name,
--							SQLCrisImport.dbo.medication_combined.start_date,
--							SQLCrisImport.dbo.medication_combined.End_Date,
--							SQLCrisImport.dbo.medication_combined.brcid,
--							SQLCrisImport.dbo.medication_combined.id

--FROM 						
--							SQLCrisImport.dbo.medication_combined

--WHERE		
--							(drug like '%lithium%' 
--																 or drug like '%camcolit%'  
--																 or drug like '%liskonum%' 
--																 or drug like '%priadel%' 
--																 or drug like '%li-liquid%' 
--																 --or drug like '%tca%'	  no hits  
--																 or drug like '%tricyclic%' 
--																 or drug like '%amitriptyline%' 
--																 or drug like '%vanatrip%' --frOM drugs.COm
--																 or drug like '%elavil%'   --frOM drugs.COm
--																 or drug like '%endep%'    --frOM drugs.COm
--																 or drug LIKE '%triptaf%'  --COnTAInS AMItRIpTyLINe AnD PErPHEnAZInE
--																 or drug like '%clomipramin%' 
--																 or drug like '%anafranil%' 
--																 or drug like '%dosulepin%' 
--																 or drug like '%dothiepin%' --PreViOuSLy KnoWN As DoTHIEPIN
--																 or drug like '%prothiden%' 
--																 or drug like '%prothiaden%' 
--																 or drug like '%doxepin%' 
--																 or drug like '%sinepin%' 
--																 or drug like '%sineq%'  --FroM drug.SCOm
--															   --  or drug like '%xepin%' --FRom DRUGS.CoM
--																 or drug like '%imipramine%' 
--																 or drug like '%tofranil%' -- FroM DrUGS.coM
--																 or drug like '%lofepramine%' 
--																 or drug like '%lomont%'
--																 or drug like '%nortriptyli%' 
--																 or drug like '%pamelo%'
--																 or drug like '%allegr%' 
--																 or drug like '%aventyl%'
--																 or drug like '%trimipram%' 
--																 or drug like '%surmonti%' 
--																 or drug like '%mianserin%' 
--																 or drug like '%trazodone%' 
--																 or drug like '%molipaxin%' --start of MAOI
--																 or drug like '%phenelzine%' 
--																 or drug like '%phenylethylhydrazine%'
--																 or drug like '%alazin%'
--																 or drug like '%nardil%' 
--																 or drug like '%isocarboxazid%' 
--																 or drug like '%tranylcypromin%' 
--																 or drug like '%parnate%'
--																 or drug like '%moclobemide%' 
--																 or drug like '%manerix%' 
--																 or drug like 'citalopram%' 
--																 or drug like '%cipramil%' 
--																 or drug like '%celexa%' 
--																 or drug like '%escitalopram%' 
--																 or drug like '%cipralex%'
--																 or drug like '%lexapro%'
--																 or drug like '%fluoxetine%' 
--																 or drug like '%prozac%' 
--																 or drug like '%sarafem%'
--																 or drug like '%bellzac%' --from drugs.com; used in Ireland
--																 or drug like '%oxactin%' --from drugs.com; drug company: Discovery
--																 or drug like '%fluvoxamine%' 
--																 or drug like '%faverin%' 
--																 or drug like'%paroxetin%' 
--																 or drug like '%paxil%' --from drugs.com; not specified for UK use but used in US
--																 or drug like '%seroxat%' 
--																 or drug like '%sertra%' 
--																 or drug like '%bellsert%' --from drugs.com; used in Ireland
--																 or drug like '%lustral%' 
--																 or drug like '%seretra%' --from drugs.com; used in Ireland   
--																 or drug like '%zoloft%'  -- from drugs.come; not specified for UK but used in US
--																 or drug like '%mirtazapin%' 
--																 or drug like '%zispin%' 
--																 or drug like '%mirza%'
--																 or drug like '%mirtazep%'
--																 or drug like '%reboxet%' 
--																 or drug like '%reboxat%'
--																 or drug like '%edronax%'
--																 or drug like '%venlafaxine%' 
--																 or drug like '%effexor%'
--																 or drug like '%efexor%'
--																 or drug like '%agomelatin%' 
--																 or drug like '%valdoxan%' 
--																 or drug like '%duloxetin%' 
--																 or drug like '%duloxatin%' 
--																 or drug like '%cymbalta%' 
--																 or drug like '%yentreve%' 
--																 --or drug like '%flupentixol%' 
--																 --or drug like '%fluanxol%' 
--																 --or drug like '%depixol%' 
--																 or drug like '%tryptophan%' 
--																 or drug like '%optimax%' 
--																 or drug like '%bupropio%')
																 
--																 )medication_ad
-------------------------------------------
----make medication.antidepressant table (Table name: medication.antidepressant, N = (1332489 row(s) affected))
-- proceed to next step
-------------------------------------------



-------------------------------------------
----4
-------------------------------------------
----JOINING MEDICATION TO BASE COHORT
---- flag patients who received ADs 2 weeks after referral date
-----------------------------------------

SELECT * 

INTO SQLCRIS_User.dbo.Afernandes_BaseCohort_WithAD_18092017

FROM

(
SELECT 						
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017.brcid as BaseCohortBrcid,
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017.Referral_start_date,
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017.Referral_end_date,
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017.primary_diagnosis,
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017.diagnosis_date,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.drug,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.generic_ad_name,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.start_date as MedStartDate,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.End_Date,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.brcid,
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.id

FROM 
							SQLCRIS_User.dbo.AfernandesBaseCohort18092017

LEFT JOIN			
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017 

on
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.brcid = SQLCRIS_User.dbo.AfernandesBaseCohort18092017.brcid

WHERE	
							(
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.start_date < (DATEADD(ww, 2, SQLCRIS_User.dbo.AfernandesBaseCohort18092017.Referral_start_date))
							AND
							SQLCRIS_User.dbo.Afernandes_medication_antidepressant_15092017.start_date > Referral_start_date
							)
							
) BaseCohort_with_AD
-------
--CHECKS
-------

--SELECT * 

--FROM SQLCRIS_User.dbo.Afernandes_BaseCohort_WithAD_18092017

--WHERE DATEDIFF(DD, Referral_start_date, MedStartDate) > 14
-- Checks came up with 0 row, so meets criteria
--------
--------------------------------------------
---- This table should have multiple rows per patient of recurring antidepressants
---- Create table BaseCohort_with_AD, N = (4565593 row(s) affected)
-------------------------------------------



-----------------------------------------
-- 5
-----------------------------------------
-- ORDERING THE JOINED BASE COHORT AND MEDICATION TABLE
-----------------------------------------
SELECT * 

INTO SQLCRIS_User.dbo.AfernandesRankedBaseCohortWithAD18092017

FROM

(
SELECT 						
							*,
							ROW_NUMBER  () 
							OVER (PARTITION BY 			brcid, 
								 						generic_ad_name ORDER BY SQLCRIS_User.dbo.Afernandes_BaseCohort_WithAD_18092017.MedStartDate, 
								 		 				id desc, 
								 		 				SQLCRIS_User.dbo.Afernandes_BaseCohort_WithAD_18092017.id
								 ) as ranked_medication_date

FROM 
							SQLCRIS_User.dbo.Afernandes_BaseCohort_WithAD_18092017
)RankedCohort
--------------------------------------------




-----------------------------------------
-- 6
-----------------------------------------
-- GENERATING ONE COLUMN PER ANTIDEPRESSANT
-----------------------------------------
SELECT (CASE 
			WHEN BaseCohort_with_AD.generic_ad_name like 	'%Sertraline%' 
													 and 	ranked.medication.date = 1
			THEN 1 else 0 end) sert_flag

--------------------------------------------

