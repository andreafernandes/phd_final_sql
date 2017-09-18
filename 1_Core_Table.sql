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




