-----------------------------------------
--1
-----------------------------------------
-- CORE TABLE
-- patients with referral between jan08 - dec16 and 
-- have f2f contact within 6 months of date of referral
-----------------------------------------
--SELECT * 

--INTO SQLCRIS_User.dbo.Afernandes_CoreTable21092017

--from
--				(
--							SELECT 
--										--Distinct 
--										(Referral.BrcId) as ReferralBrcid,
--										Event.BrcId as EventBrcid,
--										Accepted_Date as Referral_accepted_date,
--										Discharge_Date as Referral_end_date,
--										Referral.Spell_Number,
--										Event.Start_Date as Event_start_date,
--										Event_Type_Of_Contact_ID,
--										Referral.cn_doc_id as Referral_id,
--										Event.CN_Doc_ID as Event_id
									
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

---------
-- selecting distinct referral rows, each with latest f-2-f contact flag.
---------
--SELECT * 

--INTO SQLCRIS_User.dbo.Afernandes_CoreTable21092017_DistinctRows

--FROM 

--(

--SELECT *

--FROM

--		(

--		SELECT *,
--				ROW_NUMBER  () 
--											OVER (PARTITION BY 			Referral_id
--										 								ORDER BY Event_id, 
--										 		 						Event_id desc, 
--										 		 						Event_id
--						) as ranked_by_Event_id  

--		FROM SQLCRIS_User.dbo.Afernandes_CoreTable21092017
--		)RankedCoreTable

--WHERE ranked_by_Event_id = 1

--) CoreTableDisctintRows




----------
-- CHECKS
----------

--SELECT COUNT(DISTINCT(Referral_id))

--FROM SQLCRIS_User.dbo.Afernandes_CoreTable21092017_DistinctRows

--WHERE DATEDIFF(DD, Referral_accepted_date, Event_start_date) > 183 --(183 = definition of 6 months)

-- query returns 0 patients, so meets the criteria

--SELECT COUNT(DISTINCT(Referral_id))

--FROM  SQLCRIS_User.dbo.Afernandes_CoreTable21092017_DistinctRows

-- (232108 row(s) affected)

--SELECT COUNT(DISTINCT(ReferralBrcid))

--FROM SQLCRIS_User.dbo.Afernandes_CoreTable21092017_DistinctRows

------------------------------------------
-- MAKE A TABLE OF CORE TABLE 
--(Table name: SQLCRIS_User.dbo.CoreTable21092017, N = (232108 row(s) affected))

-- 232108 referrals; 142729 brcids

-- FINAL TABLE TO USE: SQLCRIS_User.dbo.Afernandes_CoreTable21092017_DistinctRows


