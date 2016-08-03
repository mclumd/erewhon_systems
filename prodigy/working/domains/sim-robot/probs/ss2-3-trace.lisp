(run :output-level 3 :depth-bound 50 :max-nodes 500)
Creating objects (A B C) of type BOX
Creating object KEY12 of type KEY
Creating objects (RM1 RM2) of type ROOM
Creating object DR12 of type DOOR

  2 n2 (done)
  4 n4 <*finish*>
  5   n5 (inroom c rm2)
  6   n6 op-11-17 ...no choices for bindings
  6   n7 op-1-11-2 ...no choices for bindings
  7   n9 macro-op:op-11-2-8-16 <op-16 dr12 rm1 c rm2>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<HOLDING C>)
  8     n10 (holding c)
  9     n11 op-15-7 ...no choices for bindings (I tried)
  9     n12 op-7 ...no choices for bindings (I tried)

  5   n5 (inroom c rm2)
  6   n13 op-2 ...no choices for bindings
  7   n15 <op-14 rm1 dr12 c rm2>
  8     n16 (dr-open dr12) [2]
 10     n18 <op-11 dr12>
 11       n19 (next-to robot dr12) [2]
 13       n21 macro-op:op-12-13 <op-13 rm1 dr12 c> [1]
Firing select goals rule SELECT-GOALS-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<NEXT-TO ROBOT C>)
 14         n22 (next-to robot c)
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-12>) over #<MACRO-OP: OP-12-13>
 16         n24 <op-12 rm1 c> [1]
 17           n25 (inroom robot rm1) [1]
 19           n27 macro-op:op-11-17 <op-17 rm2 rm1 dr12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<NEXT-TO C DR12>)
 20     n28 (next-to c dr12)
 22     n30 macro-op:op-12-13 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n31 macro-op:op-12-13 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n32 op-17-12 ...no choices for bindings
 21     n33 op-7-10 ...no choices for bindings
 21     n34 op-2-15 ...no choices for bindings
 21     n35 op-2-8 ...no choices for bindings
 21     n36 op-1 ...no choices for bindings
 21     n37 op-4 ...no choices for bindings
 21     n38 op-5 ...no choices for bindings
 21     n39 op-6 ...no choices for bindings
 21     n40 op-8 ...no choices for bindings
 21     n41 op-10 ...no choices for bindings
 21     n42 op-12 ...no choices for bindings
 22     n44 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n45 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n46 op-15 ...no choices for bindings
 21     n47 op-18 ...no choices for bindings
 21     n48 op-19 ...no choices for bindings
 21     n49 op-20 ...no choices for bindings
 21     n50 op-21 ...no choices for bindings

 17           n25 (inroom robot rm1) [1]
 19           n52 macro-op:op-1-11-2 <op-2 dr12 rm2 rm1>
 20     n53 (next-to c dr12)
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-1>) over #<MACRO-OP: OP-12-13>
 21     n54 op-1 ...no choices for bindings
 22     n56 macro-op:op-12-13 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n57 macro-op:op-12-13 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n58 op-17-12 ...no choices for bindings
 21     n59 op-7-10 ...no choices for bindings
 21     n60 op-2-15 ...no choices for bindings
 21     n61 op-2-8 ...no choices for bindings
 21     n62 op-4 ...no choices for bindings
 21     n63 op-5 ...no choices for bindings
 21     n64 op-6 ...no choices for bindings
 21     n65 op-8 ...no choices for bindings
 21     n66 op-10 ...no choices for bindings
 21     n67 op-12 ...no choices for bindings
 22     n69 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n70 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n71 op-15 ...no choices for bindings
 21     n72 op-18 ...no choices for bindings
 21     n73 op-19 ...no choices for bindings
 21     n74 op-20 ...no choices for bindings
 21     n75 op-21 ...no choices for bindings

 17           n25 (inroom robot rm1) [1]
 19           n77 macro-op:op-11-2-8-16 <op-16 dr12 rm2 a rm1> [3]
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<HOLDING A>
                                                                                      #<NEXT-TO C DR12>)
 20             n78 (holding a) [1]
 21             n79 op-15-7 ...no choices for bindings (I tried)
 21             n80 op-7 ...no choices for bindings (I tried)

 18           n76 op-11-2-8-16
 19           n81 macro-op:op-11-2-8-16 <op-16 dr12 rm2 b rm1> [2]
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<HOLDING B>
                                                                                      #<NEXT-TO C DR12>)
 20             n82 (holding b) [1]
 21             n83 op-15-7 ...no choices for bindings (I tried)
 21             n84 op-7 ...no choices for bindings (I tried)

 18           n76 op-11-2-8-16
 19           n85 macro-op:op-11-2-8-16 <op-16 dr12 rm2 c rm1> [1] ...goal loop with node 19
 19           n86 macro-op:op-11-2-8-16 <op-16 dr12 rm2 key12 rm1>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<HOLDING KEY12>
                                                                                      #<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 20             n87 (holding key12) [2]
 22             n89 macro-op:op-15-7 <op-7 key12>
Firing select goals rule SELECT-GOALS-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<NEXT-TO ROBOT KEY12>)
 23               n90 (next-to robot key12)
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-15>) over #<MACRO-OP: OP-12-13>
 25               n92 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n93 <op-15 rm2 key12>
 26                 n94 (inroom key12 rm2) [1]
 27                 n95 op-11-17 ...no choices for bindings
 27                 n96 op-1-11-2 ...no choices for bindings
 28                 n98 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n99 op-2 ...no choices for bindings
 28                 n101 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n103 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n104 op-17 ...no choices for bindings

 23               n90 (next-to robot key12)
 24               n105 op-12-13 ...no choices for bindings
 25               n107 macro-op:op-17-12 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n108 macro-op:op-17-12 <op-12 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n109 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-17>) over #<MACRO-OP: OP-11-17>
 27                 n110 op-17 ...no choices for bindings
 27                 n111 op-11-17 ...no choices for bindings
 27                 n112 op-1-11-2 ...no choices for bindings
 28                 n114 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n115 op-2 ...no choices for bindings
 28                 n117 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n119 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87

 23               n90 (next-to robot key12)
 24               n120 op-7-10 ...goal loop with node 87
 25               n122 macro-op:op-2-15 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n123 macro-op:op-2-15 <op-15 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n124 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-2>) over #<MACRO-OP: OP-11-17>
 27                 n125 op-2 ...no choices for bindings
 27                 n126 op-11-17 ...no choices for bindings
 27                 n127 op-1-11-2 ...no choices for bindings
 28                 n129 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 28                 n131 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n133 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n134 op-17 ...no choices for bindings

 23               n90 (next-to robot key12)
 24               n135 op-2-8 ...no choices for bindings
 24               n136 op-1 ...no choices for bindings
 24               n137 op-4 ...no choices for bindings
 24               n138 op-5 ...no choices for bindings
 25               n140 <op-6 key12 rm2> [1]
 26                 n141 (inroom key12 rm2) [1]
 27                 n142 op-11-17 ...no choices for bindings
 27                 n143 op-1-11-2 ...no choices for bindings
 28                 n145 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n146 op-2 ...no choices for bindings
 28                 n148 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n150 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n151 op-17 ...no choices for bindings

 24               n139 op-6
 25               n152 <op-6 key12 rm1> ...goal loop with node 25

 23               n90 (next-to robot key12)
 24               n153 op-8 ...no choices for bindings
 24               n154 op-10 ...goal loop with node 87
 25               n156 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n157 <op-12 rm2 key12>
 26                 n158 (inroom key12 rm2) [1]
 27                 n159 op-11-17 ...no choices for bindings
 27                 n160 op-1-11-2 ...no choices for bindings
 28                 n162 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n163 op-2 ...no choices for bindings
 28                 n165 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n167 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n168 op-17 ...no choices for bindings

 23               n90 (next-to robot key12)
 24               n169 op-13 ...no choices for bindings
 24               n170 op-18 ...no choices for bindings
 25               n172 <op-19 key12 rm2> [1]
 26                 n173 (inroom key12 rm2) [1]
 27                 n174 op-11-17 ...no choices for bindings
 27                 n175 op-1-11-2 ...no choices for bindings
 28                 n177 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n178 op-2 ...no choices for bindings
 28                 n180 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n182 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n183 op-17 ...no choices for bindings

 24               n171 op-19
 25               n184 <op-19 key12 rm1> ...goal loop with node 25

 23               n90 (next-to robot key12)
 24               n185 op-20 ...goal loop with node 87
 25               n187 <op-21 c key12 rm1> [1] ...goal loop with node 22
 25               n188 <op-21 c key12 rm2> ...goal loop with node 22

 20             n87 (holding key12) [2]
 22             n190 <op-7 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<NEXT-TO ROBOT KEY12>
                                                                                      #<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 23               n191 (next-to robot key12) [2]
 24               n192 op-12-13 ...no choices for bindings
 25               n194 macro-op:op-17-12 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n195 macro-op:op-17-12 <op-12 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n196 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-17>) over #<MACRO-OP: OP-11-17>
 27                 n197 op-17 ...no choices for bindings
 27                 n198 op-11-17 ...no choices for bindings
 27                 n199 op-1-11-2 ...no choices for bindings
 28                 n201 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n202 op-2 ...no choices for bindings
 28                 n204 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n206 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87

 23               n191 (next-to robot key12) [2]
 24               n207 op-7-10 ...goal loop with node 87
 25               n209 macro-op:op-2-15 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n210 macro-op:op-2-15 <op-15 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n211 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-2>) over #<MACRO-OP: OP-11-17>
 27                 n212 op-2 ...no choices for bindings
 27                 n213 op-11-17 ...no choices for bindings
 27                 n214 op-1-11-2 ...no choices for bindings
 28                 n216 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 28                 n218 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n220 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n221 op-17 ...no choices for bindings

 23               n191 (next-to robot key12) [2]
 24               n222 op-2-8 ...no choices for bindings
 24               n223 op-1 ...no choices for bindings
 24               n224 op-4 ...no choices for bindings
 24               n225 op-5 ...no choices for bindings
 25               n227 <op-6 key12 rm2> [1]
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n228 (inroom key12 rm2) [1]
 27                 n229 op-11-17 ...no choices for bindings
 27                 n230 op-1-11-2 ...no choices for bindings
 28                 n232 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n233 op-2 ...no choices for bindings
 28                 n235 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n237 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n238 op-17 ...no choices for bindings

 24               n226 op-6
 25               n239 <op-6 key12 rm1> ...goal loop with node 25

 23               n191 (next-to robot key12) [2]
 24               n240 op-8 ...no choices for bindings
 24               n241 op-10 ...goal loop with node 87
 25               n243 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n244 <op-12 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n245 (inroom key12 rm2) [1]
 27                 n246 op-11-17 ...no choices for bindings
 27                 n247 op-1-11-2 ...no choices for bindings
 28                 n249 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n250 op-2 ...no choices for bindings
 28                 n252 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n254 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n255 op-17 ...no choices for bindings

 23               n191 (next-to robot key12) [2]
 24               n256 op-13 ...no choices for bindings
 25               n258 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n259 <op-15 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n260 (inroom key12 rm2) [1]
 27                 n261 op-11-17 ...no choices for bindings
 27                 n262 op-1-11-2 ...no choices for bindings
 28                 n264 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n265 op-2 ...no choices for bindings
 28                 n267 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n269 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n270 op-17 ...no choices for bindings

 23               n191 (next-to robot key12) [2]
 24               n271 op-18 ...no choices for bindings
 25               n273 <op-19 key12 rm2> [1]
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n274 (inroom key12 rm2) [1]
 27                 n275 op-11-17 ...no choices for bindings
 27                 n276 op-1-11-2 ...no choices for bindings
 28                 n278 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n279 op-2 ...no choices for bindings
 28                 n281 <op-14 rm1 dr12 c rm2> ...goal loop with node 87
 28                 n283 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 87
 27                 n284 op-17 ...no choices for bindings

 24               n272 op-19
 25               n285 <op-19 key12 rm1> ...goal loop with node 25

 23               n191 (next-to robot key12) [2]
 24               n286 op-20 ...goal loop with node 87
 25               n288 <op-21 c key12 rm1> [1] ...goal loop with node 22
 25               n289 <op-21 c key12 rm2> ...goal loop with node 22

 22             n190 <op-7 key12>
 23             n290 (inroom key12 rm2) [1]
 24             n291 op-11-17 ...no choices for bindings
 24             n292 op-1-11-2 ...no choices for bindings
 25             n294 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 25
 24             n295 op-2 ...no choices for bindings
 25             n297 <op-14 rm1 dr12 c rm2> ...goal loop with node 22
 25             n299 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 25
 24             n300 op-17 ...no choices for bindings

 17           n25 (inroom robot rm1) [1]
 19           n302 <op-2 dr12 rm2 rm1>
 20     n303 (next-to c dr12)
 22     n305 macro-op:op-12-13 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n306 macro-op:op-12-13 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n307 op-17-12 ...no choices for bindings
 21     n308 op-7-10 ...no choices for bindings
 21     n309 op-2-15 ...no choices for bindings
 21     n310 op-2-8 ...no choices for bindings
 21     n311 op-1 ...no choices for bindings
 21     n312 op-4 ...no choices for bindings
 21     n313 op-5 ...no choices for bindings
 21     n314 op-6 ...no choices for bindings
 21     n315 op-8 ...no choices for bindings
 21     n316 op-10 ...no choices for bindings
 21     n317 op-12 ...no choices for bindings
 22     n319 <op-13 rm1 dr12 c> [1] ...no pending goals.
 22     n320 <op-13 rm2 dr12 c> ...goal loop with node 5
 21     n321 op-15 ...no choices for bindings
 21     n322 op-18 ...no choices for bindings
 21     n323 op-19 ...no choices for bindings
 21     n324 op-20 ...no choices for bindings
 21     n325 op-21 ...no choices for bindings

 17           n25 (inroom robot rm1) [1]
 19           n327 <op-14 rm2 dr12 c rm1> ...goal loop with node 22
 19           n329 <op-16 dr12 rm2 a rm1> [3]
 20             n330 (holding a) [1]
 21             n331 op-15-7 ...no choices for bindings (I tried)
 21             n332 op-7 ...no choices for bindings (I tried)

 18           n328 op-16
 19           n333 <op-16 dr12 rm2 b rm1> [2]
 20             n334 (holding b) [1]
 21             n335 op-15-7 ...no choices for bindings (I tried)
 21             n336 op-7 ...no choices for bindings (I tried)

 18           n328 op-16
 19           n337 <op-16 dr12 rm2 c rm1> [1] ...goal loop with node 19
 19           n338 <op-16 dr12 rm2 key12 rm1>
 20             n339 (holding key12) [2]
 22             n341 macro-op:op-15-7 <op-7 key12>
Firing select goals rule SELECT-GOALS-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<NEXT-TO ROBOT KEY12>)
 23               n342 (next-to robot key12)
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-15>) over #<MACRO-OP: OP-12-13>
 25               n344 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n345 <op-15 rm2 key12>
 26                 n346 (inroom key12 rm2) [1]
 27                 n347 op-11-17 ...no choices for bindings
 27                 n348 op-1-11-2 ...no choices for bindings
 28                 n350 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n351 op-2 ...no choices for bindings
 28                 n353 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n355 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n356 op-17 ...no choices for bindings

 23               n342 (next-to robot key12)
 24               n357 op-12-13 ...no choices for bindings
 25               n359 macro-op:op-17-12 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n360 macro-op:op-17-12 <op-12 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n361 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-17>) over #<MACRO-OP: OP-11-17>
 27                 n362 op-17 ...no choices for bindings
 27                 n363 op-11-17 ...no choices for bindings
 27                 n364 op-1-11-2 ...no choices for bindings
 28                 n366 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n367 op-2 ...no choices for bindings
 28                 n369 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n371 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339

 23               n342 (next-to robot key12)
 24               n372 op-7-10 ...goal loop with node 339
 25               n374 macro-op:op-2-15 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n375 macro-op:op-2-15 <op-15 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n376 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-2>) over #<MACRO-OP: OP-11-17>
 27                 n377 op-2 ...no choices for bindings
 27                 n378 op-11-17 ...no choices for bindings
 27                 n379 op-1-11-2 ...no choices for bindings
 28                 n381 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 28                 n383 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n385 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n386 op-17 ...no choices for bindings

 23               n342 (next-to robot key12)
 24               n387 op-2-8 ...no choices for bindings
 24               n388 op-1 ...no choices for bindings
 24               n389 op-4 ...no choices for bindings
 24               n390 op-5 ...no choices for bindings
 25               n392 <op-6 key12 rm2> [1]
 26                 n393 (inroom key12 rm2) [1]
 27                 n394 op-11-17 ...no choices for bindings
 27                 n395 op-1-11-2 ...no choices for bindings
 28                 n397 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n398 op-2 ...no choices for bindings
 28                 n400 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n402 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n403 op-17 ...no choices for bindings

 24               n391 op-6
 25               n404 <op-6 key12 rm1> ...goal loop with node 25

 23               n342 (next-to robot key12)
 24               n405 op-8 ...no choices for bindings
 24               n406 op-10 ...goal loop with node 339
 25               n408 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n409 <op-12 rm2 key12>
 26                 n410 (inroom key12 rm2) [1]
 27                 n411 op-11-17 ...no choices for bindings
 27                 n412 op-1-11-2 ...no choices for bindings
 28                 n414 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n415 op-2 ...no choices for bindings
 28                 n417 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n419 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n420 op-17 ...no choices for bindings

 23               n342 (next-to robot key12)
 24               n421 op-13 ...no choices for bindings
 24               n422 op-18 ...no choices for bindings
 25               n424 <op-19 key12 rm2> [1]
 26                 n425 (inroom key12 rm2) [1]
 27                 n426 op-11-17 ...no choices for bindings
 27                 n427 op-1-11-2 ...no choices for bindings
 28                 n429 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n430 op-2 ...no choices for bindings
 28                 n432 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n434 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n435 op-17 ...no choices for bindings

 24               n423 op-19
 25               n436 <op-19 key12 rm1> ...goal loop with node 25

 23               n342 (next-to robot key12)
 24               n437 op-20 ...goal loop with node 339
 25               n439 <op-21 c key12 rm1> [1] ...goal loop with node 22
 25               n440 <op-21 c key12 rm2> ...goal loop with node 22

 20             n339 (holding key12) [2]
 22             n442 <op-7 key12>
 23               n443 (next-to robot key12) [2]
 24               n444 op-12-13 ...no choices for bindings
 25               n446 macro-op:op-17-12 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n447 macro-op:op-17-12 <op-12 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n448 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-17>) over #<MACRO-OP: OP-11-17>
 27                 n449 op-17 ...no choices for bindings
 27                 n450 op-11-17 ...no choices for bindings
 27                 n451 op-1-11-2 ...no choices for bindings
 28                 n453 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n454 op-2 ...no choices for bindings
 28                 n456 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n458 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339

 23               n443 (next-to robot key12) [2]
 24               n459 op-7-10 ...goal loop with node 339
 25               n461 macro-op:op-2-15 <op-15 rm1 key12> [1] ...goal loop with node 25
 25               n462 macro-op:op-2-15 <op-15 rm2 key12>
Firing select goals rule SELECT-GOALS-NOT-ACHIEVED-BY-PREVIOUS-OPS-FOR-BF-OPS to get (#<INROOM KEY12 RM2>
                                                                                      #<NEXT-TO C DR12>)
 26                 n463 (inroom key12 rm2) [1]
Firing pref rule PREFER-FOLLOW-MACRO-OP-3 for (#<OP: OP-2>) over #<MACRO-OP: OP-11-17>
 27                 n464 op-2 ...no choices for bindings
 27                 n465 op-11-17 ...no choices for bindings
 27                 n466 op-1-11-2 ...no choices for bindings
 28                 n468 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 28                 n470 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n472 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n473 op-17 ...no choices for bindings

 23               n443 (next-to robot key12) [2]
 24               n474 op-2-8 ...no choices for bindings
 24               n475 op-1 ...no choices for bindings
 24               n476 op-4 ...no choices for bindings
 24               n477 op-5 ...no choices for bindings
 25               n479 <op-6 key12 rm2> [1]
 26                 n480 (inroom key12 rm2) [1]
 27                 n481 op-11-17 ...no choices for bindings
 27                 n482 op-1-11-2 ...no choices for bindings
 28                 n484 macro-op:op-11-2-8-16 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n485 op-2 ...no choices for bindings
 28                 n487 <op-14 rm1 dr12 c rm2> ...goal loop with node 339
 28                 n489 <op-16 dr12 rm1 key12 rm2> ...goal loop with node 339
 27                 n490 op-17 ...no choices for bindings

 24               n478 op-6
 25               n491 <op-6 key12 rm1> ...goal loop with node 25

 23               n443 (next-to robot key12) [2]
 24               n492 op-8 ...no choices for bindings
 24               n493 op-10 ...goal loop with node 339
 25               n495 <op-12 rm1 key12> [1] ...goal loop with node 25
 25               n496 <op-12 rm2 key12>
 26                 n497 (inroom key12 rm2) [1]
 27                 n498 op-11-17 ...no choices for bindings
 27                 n499 op-1-11-2 ...no choices for bindings
Hit node limit (500)

((:STOP :RESOURCE-BOUND :NODE) . #<OPERATOR-NODE 500 #<MACRO-OP: OP-11-2-8-16>>) 
