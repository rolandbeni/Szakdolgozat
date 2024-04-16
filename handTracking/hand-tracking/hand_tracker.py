import cv2
import mediapipe as mp
import time
import pyautogui

import os

cap=cv2.VideoCapture(0)
mpHands=mp.solutions.hands
hands=mpHands.Hands()
mpDraw=mp.solutions.drawing_utils

tipIds = [4, 8, 12, 16, 20]

pTime=0
cTime=0


while True:
    xx, yy=0, 0
    success, img = cap.read()
    img = cv2.flip(img, 1)
    ratio=600/img.shape[1]
    dim=(int(img.shape[0]*ratio),600)
    img=cv2.resize(img, dim, interpolation=cv2.INTER_LINEAR)
    imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    result = hands.process(imgRGB)
    lmList = []
    # print(result.multi_hand_landmarks)
    if result.multi_hand_landmarks:
        for handLms in result.multi_hand_landmarks:
            for id, lm in enumerate(handLms.landmark):
                # print(id, lm)
                h, w, c = img.shape
                cx, cy = int(lm.x * w), int(lm.y * h)
                # print(id,cx, cy)
                lmList.append([id, cx, cy])

                if id == 8:
                    cv2.circle(img, (cx, cy), 10, (255, 0, 255), cv2.FILLED)
                    xx, yy=cx, cy
            pyautogui.moveTo(xx, yy)
            mpDraw.draw_landmarks(img, handLms, mpHands.HAND_CONNECTIONS)
    cTime=time.time()
    fps=1/(cTime-pTime)
    pTime=cTime

    #img = detector.findHands(img)
    #lmList = detector.findPosition(img, draw=False)
    # print(lmList)

    if len(lmList) != 0:

        if lmList[tipIds[0]][1] > lmList[tipIds[0] - 1][1]:
            pyautogui.mouseDown(xx, yy, "right")
            time.sleep(0.1)
            pyautogui.mouseUp(xx, yy, "right")

        if lmList[tipIds[2]][2] < lmList[tipIds[2] - 2][2]:
            pyautogui.mouseDown(xx,yy,"left")
            time.sleep(0.1)
            pyautogui.mouseUp(xx, yy, "left")


    cv2.putText(img, str(int(fps)), (10,70), cv2.FONT_HERSHEY_PLAIN, 3, (255,0,255),3 )

    cv2.imshow("Image", img)
    cv2.waitKey(1)
    print(xx, yy)