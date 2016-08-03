(in-package "FRONT-END")

;;; Added parsing of a Basic FM Report to the code that parses a Ratios
;;; Report. [cox 15apr98]


#|
The input used to come in the following form (like *sample-input*):

("10/4/1997: 16:23:03" :report-uln-ratios-report
     ((:FM "K5F" "5009C" "great big string of data for K5F")
      (:FM "K25" "5009C" "great big string of data for K25")
      (:FM "K5B" "5009C" "great big string of data for K5B")
      ))
but now is as follows:
(setf *new-sample-input*
("10/4/1997: 16:23:03" :report-uln-ratios-report
     ((:FM "K5F" "5009C")
      (:FM "K25" "5009C")
      (:FM "K5B" "5009C")
      )
     (("great big string of data for K5F")
	("great big string of data for K25")
	("great big string of data for K5B")
	))
)

The code to process the input has stayed the same, but the argument passed to
parse-ratio-reports has changed. If arguments is assigned the value of (cddr
*new-sample-input*), then parse-ratio-reports is passed

(mapcar #'append
	(first arguments)
	(second arguments))

in order to convert to the old format. See file prodigy-suggestions.lisp,
function get-prodigy-response.

|#


(defparameter *sample-input*
  '("8/1/1997: 16:25:22" :REPORT-P4-RATIOS-REPORT ((:FM "MED" "JUNK1"
 "**************************************************************************
MED (JUNK1): FORCE MODULE MED - COA#1 MEDICAL SUPPORT UNITS.                   
**************************************************************************
#Recs  Total   Perc.   Feature
------------------------------------------------------
    7      7  100.0%   Aircraft-Type = None
    7      7  100.0%   Dest-Cc = Saudi-Arabia
    3      7   42.9%   Function = Miscellaneous-Combat-Support
    3      7   42.9%   Function = Miscellaneous-Combat-Service-Support
    3      7   42.9%   Function = Miscellaneous-Combat
    2      7   28.6%   Function = Medical-Surgical-Dental
    1      7   14.3%   Function = Major-Transportation
    1      7   14.3%   Function = Maintenance
    6      7   85.7%   Phasing = Early
    1      7   14.3%   Phasing = Unspecified
    6      7   85.7%   Pod-Mode = Air
    1      7   14.3%   Pod-Mode = Unspecified
    6      7   85.7%   Pod-Source = Amc
    1      7   14.3%   Pod-Source = In-Place
    7      7  100.0%   Provorg = Uscincpac
    7      7  100.0%   Service = Marines

"))))


;;;
;;; See function handle-ratio-rep in file prodigy-suggestions.lisp.
;;;
(defvar *ratio-reports* nil
  "A list of the current ratio reports processed this session.")


;;;
;;; Example call: (parse-ratio-reports (third *sample-input*))
;;;
;;; Sample output:
#|
(((FORCE-MODULE "MED") (OPLAN "JUNK1")
  (RATIO-REPORT
   ((7 7 100.0 AIRCRAFT-TYPE NONE) (7 7 100.0 DEST-CC SAUDI-ARABIA)
    (3 7 42.9 FUNCTION MISCELLANEOUS-COMBAT-SUPPORT)
    (3 7 42.9 FUNCTION MISCELLANEOUS-COMBAT-SERVICE-SUPPORT) (3 7 42.9 FUNCTION MISCELLANEOUS-COMBAT)
    (2 7 28.6 FUNCTION MEDICAL-SURGICAL-DENTAL) (1 7 14.3 FUNCTION MAJOR-TRANSPORTATION)
    (1 7 14.3 FUNCTION MAINTENANCE) (6 7 85.7 PHASING EARLY) (1 7 14.3 PHASING UNSPECIFIED)
    (6 7 85.7 POD-MODE AIR) (1 7 14.3 POD-MODE UNSPECIFIED) (6 7 85.7 POD-SOURCE AMC)
    (1 7 14.3 POD-SOURCE IN-PLACE) (7 7 100.0 PROVORG USCINCPAC) (7 7 100.0 SERVICE MARINES)))))
|#
;;;
(defun parse-ratio-reports (report-recs)
  "Return a formatted set of force-module ratio reports."
  (cond ((null report-recs)
	 nil)
	(t
	 (cons (process-report (first report-recs))
	       (parse-ratio-reports (rest report-recs)))))
  )


;;; The parameter each-report passed to function process-report will have the
;;; form as the first item in the list defined as the third item of
;;; *sample-input*. That is, (:FM "FM-ID" "OPlan-id" "Report-String").
;;;
(defun process-report (each-report 
		       &optional
		       (which-report :ratio-rep)
		       trim-ulns-p
		       )
  `((force-module ,(second each-report))
    (oplan ,(third each-report))
    ,(case which-report
	   (:ratio-rep
	    `(ratio-report ,(parse-ratio-string 
			     (fourth each-report)))
	    )
	   (:basic-fm-rep
	    `(basic-fm-report ,(parse-basic-fm-string 
				(fourth each-report)
				trim-ulns-p
				))
	    )))
  )

;;;
;;; Function parse-ratio-string is the function that translates the ForMAT
;;; ratio report record into a form that Prodigy can understand. An example of
;;; the input is given above in program parameter *sample-input*. The target
;;; input to parse is the string that is within the third position of the
;;; sample list. It is formatted with nonstandard characters such as Newline
;;; and the pound symbol that are treated in special ways by the Lisp
;;; reader. We strip out the Newlines and percent signs from the string, delete
;;; all characters up and including the pound sign (assumed to always be
;;; present), wrap parens around the remainder, and pass the string to
;;; read-from-string to convert it to a Lisp list structure. The report header
;;; is removed and the result is then passed to the function
;;; change-2-records. It subsequently returns a list of records, each being a
;;; sublist that contains a report entry (i.e., Recs Total Percent Feature
;;; Value).
;;;
;;; Example call:
;;; (parse-ratio-string (fourth (first (third *sample-input*))))
;;;
;;; NOTE that this function is redefined in source/prodigy-patch.lisp
;;;
#+original
(defun parse-ratio-string (input-string)
  ;; Structure the format by placing records in sublists
  (change-2-records
   ;; Remove the ratio report header titles 
   (cdr
    (cddddr
     (read-from-string 
      ;; Make sure that string is parsed as a list
      (massage-string input-string "\#Recs ")))))
  )


;;;
;;; Function parse-ratio-string is the function that translates the ForMAT
;;; ratio report record into a form that Prodigy can understand. An example of
;;; the input is given above in program parameter *sample-input*. The target
;;; input to parse is the string that is within the third position of the
;;; sample list. It is formatted with nonstandard characters such as Newline
;;; and the pound symbol that are treated in special ways by the Lisp
;;; reader. We strip out the Newlines and percent signs from the string, delete
;;; all characters up and including the pound sign (assumed to always be
;;; present), wrap parens around the remainder, and pass the string to
;;; read-from-string to convert it to a Lisp list structure. The report header
;;; is removed and the result is then passed to the function
;;; change-2-records. It subsequently returns a list of records, each being a
;;; sublist that contains a report entry (i.e., Recs Total Percent Feature
;;; Value).
;;;
;;; Example call:
;;; (parse-ratio-string (fourth (first (third *sample-input*))))
;;;
(defun parse-ratio-string (input-string)
  ;; Structure the format by placing records in sublists
  (change-2-records
   ;; Remove the ratio report header titles 

   (read-from-string
    (let ((start 0))
      ;; Remove the ratio report header titles (5 lines)
      (dotimes (i 5)
	       (setq start (1+ (position #\Newline input-string :start start))))
      (concatenate 'string "("
		   ;; Change newlines and percent signs into spaces
		   (substitute #\Space #\% 
			       (substitute #\Space #\Newline 
					   (subseq input-string start)))
		   ")")
      ))))


(defparameter
  *sample-fm-report*
  '("3/2/1998: 14:47:31" :REPORT-P4-BASIC-REPORT ((:FM "CV2" "PLANM"))
 (("********* CV2 (PLANM) *********
TITLE:   FORCE MODULE CV2- IIIMEF AND CVBG W/ARG FORCES.             
FEATURES:
          AC-QUANTITY: NONE
          AIRCRAFT-TYPE: NONE
          ALTERNATE-FM: NONE
          ALTERNATE-ULN: NONE
          AUGMENTATION-REQUIRED: NONE
          CAPABILITY: COMBAT-FORCES
          CAPABILITY: COMBAT-SUPPORT
          CAPABILITY: COMBAT-SERVICE-SUPPORT
          CAPABILITY: RECONNASSANCE
          CHILD: NONE
          CLIMATE: NONE
          COA: NONE
          CREATING-ORG: NONE
          CREATION-DATE: 2-5-1998
          CREATOR: AMM
          DEST-CC: KOREA-SOUTH
          EMPLOYMENT-DAYS: NONE
          FORCE: III-MEF
          FORCE: CARRIER-BATTLE-GROUP
          FORCE: ARG
          FORCE: MAGTF-MEF-SIZE
          FORCE-QUANTITY: NONE
          FUNCTION: AIR-CONTROL-UNITS
          FUNCTION: ARTILLERY
          FUNCTION: AVIATION-FLIGHT-UNITS
          FUNCTION: AVIATION-SUPPORT
          FUNCTION: AVIATION-TACTICAL
          FUNCTION: COMMAND-HQ
          FUNCTION: ENGINEERS-AND-TOPOGRAPHIC-SERVICES
          FUNCTION: FLEET-AUXILIARIES
          FUNCTION: GROUND-COMMUNICATIONS-ELECTRONICS-SIGNAL
          FUNCTION: INFANTRY
          FUNCTION: INTELLIGENCE-COUNTERINTELLIGENCE
          FUNCTION: INTELLIGENCE-SECURITY-PSYOPS
          FUNCTION: MAINTENANCE
          FUNCTION: MAJOR-TRANSPORTATION
          FUNCTION: MEDICAL-SURGICAL-DENTAL
          FUNCTION: MILITARY-POLICE-AND-LAW-ENFORCEMENT
          FUNCTION: MISCELLANEOUS
          FUNCTION: MISCELLANEOUS-COMBAT
          FUNCTION: MISCELLANEOUS-COMBAT-SERVICE-SUPPORT
          FUNCTION: MISCELLANEOUS-COMBAT-SUPPORT
          FUNCTION: ORDNANCE-SYSTEMS-ACTIVITIES
          FUNCTION: SUPPLY-SUPPORT-SERVICES
          FUNCTION: TRACKED-VEHICLES
          FUNCTION: WARSHIPS-CRAFT-AND-COMMANDS
          GEOGRAPHIC-LOCATION: KOREA-SOUTH
          GOAL: CONDUCT-NEO
          GOAL: ISOLATE-THE-BATTLEFIELD
          ID: CV2
          LATITUDE: NONE
          LOCATION: WESTERN-PACIFIC
          LONGITUDE: NONE
          MISSION: SUPPORT-KOREA-FDO
          MISSION-TYPE: NONE
          MNEMONIC-ID: NONE
          MODE: NONE
          MODIFICATION-DATE: 2-18-1998
          MODIFIER: AMM
          OBTAINED-BY: NONE
          OPLAN: PLANM
          ORIG-FM: CV2
          ORIG-OPLAN: |52173|
          ORIGIN: WESTERN-PACIFIC
          COMMON-BASE:PARENT: T0P
          PHASING: EARLY
          POD-MODE: AIR
          POD-MODE: SEA
          POD-SOURCE: AMC
          POD-SOURCE: SUPPORTED-CINC
          POD-SOURCE: UNITS-ORGANIC-AIRCRAFT
          PREDECESSOR: NONE
          PROVORG: HQ-US-MARINES
          PROVORG: HQ-US-NAVY
          PROVORG: NAVY-COMPONENT-OF-SUPPORTED-CINC
          PROVORG: USCINCPAC
          RELATED-FM: NONE
          REQUIRING-ORG: NONE
          ROLE: NONE
          SERVICE: MARINES
          SERVICE: NAVY
          SOF-FEATURE: NONE
          STATUS: NONE
          SUBGOAL: NAVAL-BLOCKADE
          SUCCESSOR: NONE
          TERRAIN: NONE
          THEATER: PACOM
          THREAT-COUNTERED: DETER-AGRESSION
          TYPE: NONE
          UNIT-NAME: NONE
          UNIT-ROLE: NONE

ULNS:
      U-NABAA  : N : 5CVC1 : USS : CV CARRIER (CLASS 59)          
      U-NABAB  : N : G6GGD : DET : EOD MU SHIP DET                
      U-NABAF  : N : 524BA : CMD : COM CARRIER STRIKE FORCE       
      U-NABBA  : N : 3LVAB : WG  : COM CARRIER AIR WING           
      U-NABBB  : N : 3FA18 : SQ  : STRKFITRON (10) F/A-18         
      U-NABBD  : N : 3FA18 : SQ  : STRKFITRON (10) F/A-18         
      U-NABBF  : N : 3F141 : SQ  : FITRON (10)F14                 
      U-NABBH  : N : 3F141 : SQ  : FIGHTER SQDN (10) F-14         
      U-NABBJ  : N : 3A604 : SQ  : ATKRON (10)A6E/(4)KA6D         
      U-NABBK  : N : 3EA61 : SQ  : TACELRON (5)EA6B               
      U-NABBM  : N : 3GS59 : SQ  : HELO ASW SQ (6) SH-3H          
      U-NABBN  : N : 3E2C2 : SQ  : CARAEWRON (4) E2C              
      U-NABBQ  : N : 3S301 : SQ  : AIRANTISUBRON (6)S-3           
      U-NABCA  : N : 5JCGD : USS : CG-CRUISER                     
      U-NABCB  : N : 5JCGD : USS : CG-CRUISER                     
      U-NABCD  : N : 5DDD3 : USS : DD-DESTROYER (CLASS 963)       
      U-NABCF  : N : 5DDD3 : USS : DD-DESTROYER (CLASS 963)       
      U-NABCG  : N : 5JCGD : USS : CG-CRUISER                     
      U-NABCL  : N : 3GSLA : DET : HELO ASW LAMPS DET (1) SH-2F   
      U-NABCN  : N : 3GSLA : DET : HELO ASW LAMPS DET (1) SH-2F   
      U-NABCS  : N : 3GSLA : DET : HELO ASW LAMPS DET (1) SH-2F   
      U-NABCT  : N : 5GEGA : USS : FFG-GUIDED MISSILE FRIGATE     
      U-NABEA  : N : MUAE2 : USS : (AE) AMMUNITION SHIP (CLASS 26)
      U-NABEB  : N : G6GGD : DET : EOD MU SHIP DET                
      U-NABED  : N : 3JY65 : DET : HELICOPTER COMBAT SUPPORT DETAC
      U-NABEF  : N : MUFSA : USS : AFS-COMBAT STORE SHIP (CL.1)   
      U-NABEG  : N : 3JY65 : DET : HELICOPTER COMBAT SUPPORT DETAC
      U-NABEH  : N : MSA0A : MSC : TAO-TANKER (MSC)               
      U-NABEJ  : N : MSAEA : MSC : TAE-AMMUNITION SHIP(MSC)       
      U-NABEK  : N : MU0RA : USS : AOR-REPLENISHMENT (CLASS 1)    
      U-NABEL  : N : G6GGD : DET : EOD MU SHIP DET                
      U-NAMAA  : N : 5LKAA : USS : LKA-AMPHIBIOUS CARGO SHIP      
      U-NAMAD  : N : 5LPDA : USS : LPD-AMPH. TRANSPORT DOCK       
      U-NAMAG  : N : 5LSDA : USS : LSD-LANDING SHIP DOCK          
      U-NAMAH  : N : 5LSTA : USS : LST-TANK LANDING SHIP(CL1179)  
      U-NAMAJ  : N : 5LSTA : USS : LST-TANK LANDING SHIP(CL1179)  
      U-NAMAK  : N : 5LHAA : USS : LHA-AMPH. ASSAULT (CLASS 1)    
      U-NAMAM  : N : 3JATA : SQ  : TACTICAL AIR CONTROL SQ        
      U-NAMAN  : N : U7ACB : DET : ASSAULT CRAFT UNIT BOAT GROUP T
      U-NAMAQ  : N : U7ACB : DET : ASSAULT CRAFT UNIT BOAT GROUP T
      U-NAMAR  : N : U7ACB : DET : ASSAULT CRAFT UNIT BOAT GROUP T
      U-NAMAS  : N : Y39EN : DET : AMPHIBIOUS CONSTRUCTION BN DET 
      U-NAMAT  : N : Y26FA : U   : BEACHMASTER UNIT               
      U-NAMAU  : N : 5LHAA : USS : LHA-AMPH. ASSAULT (CLASS 1)    
      U-NAMAV  : N : G6GGD : DET : EOD MU SHIP DET                
      U-NAMAW  : N : 5LPDA : USS : LPD-AMPH. TRANSPORT DOCK       
      U-NAMGA  : N : 5LCCA : USS : LCC-AMPH. COMMAND (CLASS 19)   
      U-NFAA   : M : C99BB : DET : MEF LIAISON TEAM CPTANGO       
      U-NFAB   : M : C99BB : DET : HQ III MEF ADV PARTY           
      U-NFAC   : M : CBSAA : HQ  : HQS, MARINE EXPED FORCE        
      U-NFAD   : M : 9BUAA : HQS : H&S CO, MEF HQ, MEF            
      U-NFAE   : M : Z99BB : HQ  : HQSVCBN FMF                    
      U-NFBAA01: M : PGBAD : HQ  : HQS, SRI GROUP                 
      U-NFBAA02: M : PGBAB : HQS : H&S CO, 3D SRI GROUP           
      U-NFBBA  : M : PTLAA : CO  : FORCE RECON CO, FMF            
      U-NFBCE  : M : 3LDAA : U   : FORCE IMAGERY INTER UNIT, SRI  
      U-NFBCG  : M : PYDLK : DML : COUNTER INTEL TEAM, FMF        
      U-NFBCL  : M : PRPAA : CO  : RPV CO, SRI                    
      U-NFBDA  : M : 9UJAA : HQC : HQ CO, COMM BN, SRI            
      U-NFBDB  : M : 6UKAA : CO  : COMM CO, COMM BN, SRI GRP      
      U-NFBDD  : M : 6UNAA : CO  : COMM SPT CO, COMM BN, SRI GRP  
      U-NFDAB01: M : 9GCAA : HQ  : DIV HQ, HQ CO, HQ BN, DIV      
      U-NFDAB02: M : 9GCAA : HQ  : DIV HQ, HQ CO, HQ BN, DIV      
      U-NFDAD01: M : 9GCAA : HQ  : DIV HQ, HQ CO, HQ BN, DIV      
      U-NFDAD02: M : 9GCAA : HQ  : DIV HQ, HQ CO, HQ BN, DIV      
      U-NFDBC  : M : 9GEAA : HQC : HQ CO, HQ BN, DIV              
      U-NFDBP  : M : 9GEAA : HQC : HQ CO, HQ BN, DIV              
      U-NFDCP  : M : 9GGAA : SCO : SERVICE CO, HQ BN, DIV         
      U-NFDEC  : M : 6GJAA : CO  : COMM CO, HQ BN, DIV            
      U-NFDEP  : M : 6GJAA : CO  : COMM CO, HQ BN, DIV            
      U-NFDFP  : M : UJEGA : CO  : TRUCK CO, HQ BN, DIV           
      U-NFEA   : M : 9GSAA : HQC : HQ CO, INF REGT                
      U-NFEB   : M : 0GTAA : BN  : INF BN, FMF                    
      U-NFFCP  : M : 9HEAA : BTY : HQ BTY, ARTY REGT, DIV         
      U-NFFDA  : M : 9HLAA : BTY : HQ BTY, DS BN (T) M198         
      U-NFFDB  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NFFDD  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NFFDE  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN, DIV     
      U-NFFD1  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN, 2D DIV  
      U-NFFD2  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN, 2D DIV  
      U-NFFEA  : M : 9HLAA : BTY : HQ BTY, DS BN (T) M198         
      U-NFFEE  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NFFEP  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NFFE2  : M : 9HLAA : BTY : HQ BTY, DS BN (T) M198 2D DIV  
      U-NFFE3  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN, 2D DIV  
      U-NFJAP  : M : 9TRAA : HQS : H&S CO, CSG                    
      U-NFJB   : M : 2VLA3 : CO  : LIGHT ARMORED RECON CO, (-)    
      U-NFJB1  : M : 2VLA3 : CO  : LAI CO, LAI BN                 
      U-NFJD   : M : 2TXAB : CO  : AA CO                          
      U-NFJE   : M : 9HUGA : HQS : H&S CO, CBT ENGR BN, DIV       
      U-NFJE1  : M : 9HUGA : HQS : H&S CO, CBT ENGR BN, DIV       
      U-NFJF   : M : 4HVJA : DMR : CBT ENGR SPT CO                
      U-NFJF1  : M : 4HVJA : DMR : CBT ENGR SPT CO, -MEBMEUDET    
      U-NFJG   : M : 4HWGA : CO  : CBT ENGR CO, CBT ENGR BN, DIV  
      U-NFJGA  : M : 4HWLE : PLT : CBT ENGR PLT, CBT ENGR BN, DIV 
      U-NFJG1  : M : 4HWGA : CO  : CBT ENGR CO, CBT ENGR BN, DIV  
      U-NFJH   : M : 4HWGA : CO  : CBT ENGR CO, CBT ENGR BN, DIV  
      U-NFJHA  : M : 4HWLE : PLT :   CBT ENGR PLT, CBT ENGR BN    
      U-NFJH1  : M : 4HWGA : CO  : CBT ENGR CO, CBT ENGR BN, DIV  
      U-NFKB   : M : PHRAA : CO  : RECON CO                       
      U-NFKB1  : M : PHRAA : CO  : RECON CO, RECON BN, DIV        
      U-NFKD   : M : PHRAA : CO  : RECON CO, 4TH MAR,DIV          
      U-NFLA   : M : 9GSAA : HQC : HQ CO, INF  REGT, DIV          
      U-NFLB   : M : 0GTAA : BN  : INF BN, FMF                    
      U-NFLD   : M : 0GTAA : BN  : INF BN, FMF                    
      U-NFPA   : M : C99BB : TM  : 1ST MAW LIAISON TM             
      U-NFPB   : M : C99BB : HQ  : HQ 1ST MAW (FWD)/III MEF (FWD) 
      U-NFPE   : M : 999BB : DET : 3D FSSG ACF                    
      U-NFPF   : M : 999BB : DET : 3D FSSG ACF                    
      U-NFPH   : M : 8LKAA : HQ  : MARINE WING HQ SQDN, MAW       
      U-NFPJ   : M : 8LKAA : HQ  : MARINE WING HQ SQDN, MAW       
      U-NFPL   : M : PUEAA : TM  : SPEC SECURITY COMM TEAM, FMF   
      U-NFQAD  : M : 7LQEC : DMB : DET, MATCS, MACG               
      U-NFQAF  : M : 7LQEC : DMB : DET, MATCS, MACG-18            
      U-NFQAG  : M : 7LQEC : DMB : DET, MATCS, MACG               
      U-NFQBF  : M : 8LPC2 : DMB : DET, H&HS, MACG-18             
      U-NFQCD  : M : 7LRAB : DET : DET, MASS, MACG                
      U-NFQDD  : M : 7LSAA : SQ  : MACS-4, MACG-18                
      U-NFQFA  : M : 3LUEE : DMU : DET (MEU) STINGER PLT, LAAD BN 
      U-NFQFB  : M : 3LUEE : DMU : 1ST LAAD BN, DET 2             
      U-NFQFF  : M : 3LUEE : DMU : DET (MEU) STINGER PLT, LAAD BN 
      U-NFQFQ  : M : 3LUEE : DMU : DET, LAAD BN                   
      U-NFQGA  : M : 8LZAC : DET : DET, MWCS                      
      U-NFQGB  : M : 8LZAC : DET : DET, MWCS                      
      U-NFRAA  : M : 8NHAA : HQ  : MAG-12                         
      U-NFRAB  : M : 8NHAA : HQ  : MAG-12                         
      U-NFRAD  : M : 8NHAA : HQ  : MAG-12                         
      U-NFRAF  : M : 8NHAA : HQ  : MAG-12 (FOL-ON)                
      U-NFRAH  : M : Z99BB : NSL : DET, MAG-12                    
      U-NFRAJ  : M : Z99BB : NSL : DET, MAG-12                    
      U-NFRAK  : M : Z99BB : NSL : DET, MAG-12                    
      U-NFRBD  : M : 3NNNA : SQ  : VMFA (P) (12 F/A-18 A/C)       
      U-NFRBF  : M : 3NNNA : SQ  : VMFA (P)                       
      U-NFRBG  : M : 3NNNA : SQ  : VMFA (P)                       
      U-NFRBH  : M : 3NNNC : SQ  : VMFA (L) (12 F/A-18)           
      U-NFRBJ  : M : 3NNNC : SQ  : VMFA (L)                       
      U-NFRBK  : M : 3NNNC : SQ  : VMFA (L)                       
      U-NFRBL  : M : 3NSAA : SQ  : VMA (14 AV-8B A/C)             
      U-NFRBM  : M : 3NSAA : SQ  : VMA, DET                       
      U-NFRBQ  : M : 3NNNC : SQ  : VMFA (AW) (12 F/A-18D)         
      U-NFRBR  : M : 3NNNC : SQ  : VMFA (AW)                      
      U-NFRBS  : M : 3NNNC : SQ  : VMFA (AW)                      
      U-NFRBT  : M : 3QJNA : SQ  : VMAQ (6 EA-6B A/C)             
      U-NFRBU  : M : 3QJNA : SQ  : VMAQ                           
      U-NFRBV  : M : 3QJNA : SQ  : VMAQ                           
      U-NFRCA  : M : 8NJAA : SQ  : MALS-12 F/A-18 FISP            
      U-NFRCD  : M : 8NJAA : SQ  : MALS-12 F/A-18D FISP           
      U-NFRCH  : M : 8NJAA : SQ  : MALS-12 EA-6B FISP             
      U-NFRCL  : M : 399BB : DET : MALS-12 AV-8B FISP             
      U-NFRCN  : M : 8NJAA : SQ  : MALS-12 AV-8B FISP             
      U-NFRCQ  : M : 8NJAA : SQ  : MALS-12 PCSP                   
      U-NFRCR  : M : 8NJAA : SQ  : MALS-12, F/A-18D PCSP          
      U-NFRCS  : M : 8NJAA : SQ  : MALS-12, EA-6B PCSP            
      U-NFRCT  : M : 8NJAA : SQ  : MALS-12, AV-8B PCSP            
      U-NFSA   : M : 8PCNA : SQ  : MALS-36 ADV PTY/MAIN BODY      
      U-NFSAA  : M : 8PCNA : SQ  : MALS (ROTARY WING)             
      U-NFSB   : M : 3PLFE : DET : HMH (4 CH-53E A/C)             
      U-NFSC   : M : 3PLFE : DET : HMH (4CH-53E A/C)              
      U-NFSE   : M : 3PLFE : DET : HMH (CARGO/MAIN BODY)          
      U-NFSF   : M : 3MQEC : SQ  : VMGR (6 KC-130 A/C)            
      U-NFSG   : M : 3MQEC : SQ  : VMGR (6 KC-130 A/C)            
      U-NFSMA  : M : 3PQAA : SQ  : HML/A 8 AH-1W/8 UH-1N COMPO    
      U-NFSMD  : M : 3PQAA : SQ  : HML/A (MAIN BODY)              
      U-NFSNA  : M : 3PNGA : SQ  : HMM (12 CH-46E)                
      U-NFSNB  : M : 399BB : DMU : HMM (MAIN BODY)                
      U-NFSND  : M : 399BB : DMU : HMM (CARGO)                    
      U-NFSQ   : M : 399BB : DMB : MAG-36 ADV PTY                 
      U-NFSR   : M : 399BB : SQ  : MAG-36                         
      U-NFTA   : M : 8MLGA : SQ  : MWSS                           
      U-NFTD   : M : 8MLUA : SQ  : MWSS (F/W) MWSG, MAW           
      U-NFTG   : M : 8MMU3 : DML : MWSS (ROTARY) MWSG,            
      U-NFTH   : M : 8MLUA : SQ  : H&HS-17 (PAX)                  
      U-NFTJ   : M : 8MMU3 : DML : MWSS (ROTARY) MWSG             
      U-NFTK   : M : Z99BB : NSL : DET, MWSS-171, MWSG-17         
      U-NFTL   : M : Z99BB : NSL : DET, MWSS-172, MWSG-17         
      U-NFUAA01: M : 9VDG1 : DMM : HQS CO, H&S BN                 
      U-NFUAD01: M : 9VEG1 : DMM : SERVICE CO, H&S BN             
      U-NFUAG01: M : QVHJ2 : DMM : MP CO, H&S BN                  
      U-NFUAK01: M : 6VFG1 : DMM : COMM CO, H&S BN                
      U-NFUBA01: M : 9WCC2 : DMM : H&S CO, ENGR SPT BN            
      U-NFUBG01: M : 4WGGA : CO  : BRDG CO, ENGR SPT BN           
      U-NFUBH01: M : 4WGGA : CO  : ENGR CO, ENGR SPT BN           
      U-NFUBK01: M : 4WGGA : CO  : ENGR CO, ENGR SPT BN           
      U-NFUBN01: M : 4WDA1 : DMM : ENGR SPT CO                    
      U-NFUBS01: M : 4WFGA : CO  : BULK FUEL CO, ENGRSPTBN        
      U-NFUCA01: M : 9VJGA : HQS : H&S CO, LDG SPT BN             
      U-NFUCD01: M : 9VJUA : CO  : LDG SPT CO, LDG SPT BN         
      U-NFUCF01: M : 9VJUA : CO  : LDG SPT CO, LDG SPT BN         
      U-NFUCK01: M : 9VJQ2 : DMM : B&T OPS CO, LDG SPT BN         
      U-NFUCM01: M : 9VJUR : CO  : LDG SPT EQPT CO, LSB           
      U-NFUDA01: M : 9VUC2 : DMM : H&S CO, SUPPLY BN              
      U-NFUDD01: M : JVVC2 : DMM : AMMO CO, SUP BN                
      U-NFUDG01: M : JVZCA : DMM : MED LOG CO, SUP BN             
      U-NFUDM01: M : JVYC2 : DMM : SUPPLY CO, SUP BN              
      U-NFUEA01: M : 9VLJ2 : DMM : H&S CO, MAINT BN               
      U-NFUED01: M : HVNL3 : DMM : ENGR MAINT CO                  
      U-NFUEG01: M : HVQL4 : DMM : MT MAINT CO                    
      U-NFUEK01: M : HVPJ2 : DMM : ORD MAINT CO                   
      U-NFUEM01: M : HVMJ2 : DMM : C/E MAINT CO, MAINT BN         
      U-NFUEQ01: M : HVSJ2 : DMM : GS MAINT CO                    
      U-NFUFA01: M : 9WKC2 : DMM : H&S CO, MT BN                  
      U-NFUFD01: M : UWLJ2 : DMM : GS TRK CO, MT BN               
      U-NFUFG01: M : UWMC2 : DMM : DS TRK CO, MT BN               
      U-NFUGA01: M : 9WRC2 : DMM : H&S CO, MED BN                 
      U-NFUGD01: M : FWTAA : CO  : COLLECT & CLEAR CO, MED BN     
      U-NFUGF01: M : FWTAA : CO  : COLLECT & CLEAR CO, MED BN     
      U-NFUGH01: M : FWTAA : CO  : COLLECT & CLEAR CO, MED BN     
      U-NFUGM01: M : FWUAA : DMM : SURGICAL SPT CO, MED BN        
      U-NFUGN01: M : FWUAA : DMM : SURGICAL SPT CO, MED BN        
      U-NFUHA01: M : FWVGA : HQS : H&S CO, DENTAL BN              
      U-NFUHD01: M : FWWAA : CO  : DENTAL CO, DENTAL BN           
      U-NFUHG01: M : FWWAA : CO  : DENTAL CO, DENTAL BN           
      U-NFUJA  : M : 999BB : DET : 3D FSSG DET YECHON             
      U-NFUKA  : M : 999BB : DET : 3D FSSG DET POHANG             
      U-NWF    : M : 1HKAA : BN  : GCE, DET 11TH MAR AMPHIB       
      U-NWFA   : M : 199BB : NSL : HQ BTRY (-), ARTY REGT         
      U-NWFB   : M : 1HKAA : BN  : ARTILLERY BN (1/11) AMPHIB     
      U-NWFBA  : M : 9HLHA : BTY : HQ BTY, DS BN, ARTY REGT       
      U-NWFBB  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFBD  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFD   : M : 199BB : NSL : ARTY BN (2/11) AMPHIB          
      U-NWFDA  : M : 9HLHA : BTY : HQ BTY, DS BN, ARTY REGT       
      U-NWFDB  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFDD  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFDF  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFE   : M : 1HKAA : BN  : ARTILLERY BN (5/11) AMPHIB     
      U-NWFEA  : M : Z99BB : NSL : HQ BTRY, ARTY BN               
      U-NWFEB  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFED  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
      U-NWFEF  : M : 1HJAA : BTY : 155 HOW BTY (T) DS BN          
")))
  )


;;; [cox 15apr98]
(defun parse-basic-fm-string (input-string 
			      trim-ulns-p
			      &aux
			      (report
			       (rest 
				(read-from-string  
				 (massage-string
				  input-string
				  "FEATURES:" 
				  t 
				  t)))))
  (if trim-ulns-p
      (butlast 
       (reverse 
	(member 'user::ULNS  
		(reverse 
		 report))))
    report)
  )


(defun parse-fm-reports (report-recs)
  "Return a formatted set of force-module basic FM reports."
  (cond ((null report-recs)
	 nil)
	(t
	 (cons (process-report (first report-recs)
			       :basic-fm-rep
			       nil) ;do not trim ulns
	       (parse-fm-reports (rest report-recs)))))
  )



(defun massage-string (input-string &optional delimiter strip-colons-p strip-commas-p)
  (concatenate 'string 
	       "(" 
	       ;; Strip everything up to the delimiter string
	       (subseq 
		;; Change newlines, percent signs, and perhaps colons and commas into spaces
		(substitute #\Space
			    #\% 
			    (substitute #\Space
					#\Newline 
					(if (and strip-colons-p strip-commas-p)
					    (substitute #\Space
							#\:
							(substitute #\Space
								    #\,
								    input-string))
					  (if strip-colons-p
					      (substitute #\Space
							  #\:
							  input-string)
					    input-string))))
		(1+ 
		 ;; Changed to search because there can be arbitrary pound
		 ;; symbols in the title. [29oct97 cox]
		 (search delimiter input-string)
		 ;; (position #\# input-string)
		 ))
	       ")" )
  )


;;;
;;; Work in progress. [cox 8mar98 9mar98]
;;;
(defun parse-guidance-4-alert-units (input-string &aux *y*)
  (setf *y* (rest (member '(u) 
			  (read-from-string 
			   (massage-string
			    input-string 
			    "DEPLOYMENT ORDERS" 
			    t))
			  :test #'equal)))
  (reverse 
;   (rest 
    (set-difference *y* (member 'ALERTED *y*))
    )
  )


;;;
;;; The records will be in the form (Recs Total Percentage Feature Value)
;;;
(defun change-2-records (ratio-rep)
  "Change ratio report from a flat representation to structured one."
  (cond ((null ratio-rep) nil)
	(t
	 (cons 
	  (list
	   (first ratio-rep)
	   (second ratio-rep)
	   (third ratio-rep)
	   (fourth ratio-rep)
	   ;; Skip the equal sign
	   (sixth ratio-rep))
	  (change-2-records (cddr (cddddr ratio-rep))))))
  )


(defun get-feature (record)
  "Return the feature field of record"
  (fourth record)
  )


(defun get-val (record)
  "Return the value field of record"
  (fifth record)
  )



(defun get-records (feature records)
  "Get all the records that match on feature."
  (cond ((null records) nil)
	((eq feature
	     (get-feature
	      (first records)))
	 (cons (first records)
	       (get-records feature (rest records))))
	(t
	 (get-records feature (rest records))))
  )


;;;
;;; Predicate ok-to-suggest-change-p returns t iff the report contains at least
;;; one record that has a matching feature value equal to from-module. For
;;; instance, the from-module might be 'A10-A, the feature may be
;;; aircraft-type, and the predicate returns t if the input report has at least
;;; one aircraft-type record whose value is also 'A10-A. The reason is that
;;; Prodigy does not want to suggest that the ForMAT user change the
;;; from-module to another value if the ratio report does not show that a
;;; corresponding force module currently exist in the TPFDD (the user could
;;; have previously made the change).
;;;
(defun ok-to-suggest-change1-p (from-module 
			       feature 
			       report 
			       &optional pre-parsed-report)
  (let* ((parsed-report (or pre-parsed-report
			    (parse-ratio-reports (third report))))
	 (matching-records (get-records feature 
					(second (third parsed-report))))
	 (has-match nil))
    (dolist (each-rec matching-records)
	    (if (eq (get-val each-rec) 
		    from-module)
		(setf has-match t)))
    has-match)
  )


;;; Returns t iff not all records have the new value.
(defun ok-to-suggest-change2-p (new-value 
				feature 
				report 
				&optional pre-parsed-report)
  (let* ((parsed-report (or pre-parsed-report
			    (parse-ratio-reports (third report))))
	 (matching-records (get-records feature 
					(second (third parsed-report))))
	 (has-mismatch nil))
    (dolist (each-rec matching-records)
	    (if (not (eq (get-val each-rec) 
			 new-value))
		(setf has-mismatch t)))
    has-mismatch)
  )



(defun dest-cc-not-already-changed-p (new-dest 
				      fm-name 
				      oplan
				      ratio-reports
				      &aux 
				      (target-report
				       (find-target fm-name oplan ratio-reports)))
  (ok-to-suggest-change2-p
   new-dest
   'user::dest-cc
   nil
   target-report)
  )

;;;
;;; Given a list of structured ratio reports (i.e., those converted from
;;; ForMAT style to Prodigy structure), return the report corresponding to OPLAN
;;; named oplan and force-module named fm-name.
;;;
(defun find-target (fm-name oplan ratio-reports
			    &aux (current-report
				  (first ratio-reports)))
  (cond ((null ratio-reports)
	 (format t 
		 "Could NOT find target ratio report~%")
	 nil)
	((and
	  (equal oplan
		 (second (second current-report)))
	  (equal fm-name
		 (second (first current-report))))
	 current-report)
	(t
	 (find-target fm-name oplan (rest ratio-reports))))
  )


(defun ok-to-suggest-add-p (new-module 
			    feature 
			    report 
			    &optional pre-parsed-report)
  (let* ((parsed-report (or pre-parsed-report
			    (parse-ratio-reports (third report))))
	 (matching-records (get-records feature 
					(second (third parsed-report))))
	 (has-match nil))
    (dolist (each-rec matching-records)
	    (if (eq (get-val each-rec) 
		    new-module)
		(setf has-match t)))
    (not has-match))
  )



;;; The form of the request is as follows:
;;; (:ON-REQUEST :RATIO-REPORT ((:FM <FORCE-MODULE> <OPLAN>)+))
;;;
;;; NOTE that this function is redefined in watchdog/prodigy-patch.lisp
;;;
#+original
(defun request-reports (oplan fmid-mappings)
  "Request a series of ratio reports from ForMAT."
  (format t 
	  "Writing output request, file # ~D~%" 
	  *prodigy-output-count*)
  (setq *prodigy-temp-filename*
	(format nil 
		"~A.prodigy.temp.~A"
		*basename*
		*prodigy-output-count*))
  (with-open-file (out *prodigy-temp-filename* :direction :output)
		  (format out 
			  "(:ON-REQUEST :RATIO-REPORT ~S~%" 
			  (assemble-args oplan fmid-mappings))
		  (format out 
			  ")~%"))
  (rename-file *prodigy-temp-filename*
	       (format nil 
		       "~A.server.~A"
		       *basename*
		       *prodigy-output-count*))
  (incf *prodigy-output-count*)

  )


;;; ============================================================
;;; From ratio-rep.lisp
;;; ============================================================

;;; The form of the request is as follows:
;;; (:ON-REQUEST {:RATIO-REPORT | :FM-REPORT} ((:FM <FORCE-MODULE> <OPLAN>)+))
;;;
(defun request-reports (oplan fmid-mappings
			      &optional 
			      (which-report :ratio-rep))
  "Request a series of ratio reports from ForMAT."

  (format t 
	  "Writing output request for ~s, file # ~D~%" 
	  (case which-report
		 (:ratio-rep :RATIO-REPORT)
		 (:basic-fm-rep :FM-REPORT)
		 )
	  (1+ watchdog::*watchdog-sent-message-count*))

  (watchdog::watchdog-send-message 
   (format nil 
	   "(:ON-REQUEST ~S ~S)~%" 
	   ;; [cox 15apr98]
	   (case which-report
		 (:ratio-rep :RATIO-REPORT)
		 (:basic-fm-rep :FM-REPORT)
		 )
	   (assemble-args oplan fmid-mappings))
   :convert nil)
  )


;;; The fmid-mappings is of the form ((<FM-ID> "string")+)
;;;
(defun assemble-args (oplan fmid-mappings)
  "Assemble the arguments for a report request."
  (mapcar #'(lambda (each-mapping)
	     (list :FM 
		   (second each-mapping)
		   oplan))
	  fmid-mappings)
  )
