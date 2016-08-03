(require :socket)

(setf simple-prob '(((goal (at obj11 pos1))
(goal (at obj12 apt1))
(in-city apt1 cit1)
(in-city apt3 cit3)
(in-city pos1 cit1)
(in-city pos3 cit3)
(airplane apn1)
(airport apt1)
(airport apt3)
(location apt1)
(location apt3)
(location pos1)
(location pos3)
(city cit1)
(city cit3)
(truck tru1)
(truck tru3)
(at apn1 apt3)
(at obj11 pos3)
(at obj12 apt1)
(at tru1 pos1)
(at tru3 apt3)
(package obj11)
(package obj12)) ((at obj11 pos1))))

(setf gb-cli (socket:make-socket :connect :active
				 :address-family :internet
				 :type :stream
				 :remote-port 45676))

(format gb-cli "~A" simple-prob)
(finish-output gb-cli)
