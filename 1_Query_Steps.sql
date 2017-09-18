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
--										id as Referral_id,
--										Event.Start_Date,
--										Event_Type_Of_Contact_ID,
--										Referral.cn_doc_id
									
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

