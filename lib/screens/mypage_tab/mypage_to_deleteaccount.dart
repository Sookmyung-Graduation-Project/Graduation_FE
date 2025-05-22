import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';

class MypageToDeleteaccount extends StatefulWidget {
  const MypageToDeleteaccount({super.key});

  @override
  State<MypageToDeleteaccount> createState() => _MypageToDeleteaccountState();
}

class _MypageToDeleteaccountState extends State<MypageToDeleteaccount> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<String> deleteMenuItems = [
      '서비스의 이용이 복잡하고 어려움',
      '서비스 장애와 오류 때문에 ',
      '탈퇴 후 신규 가입하기 위한',
      '서비스가 도움이 안 됨',
    ];

    Widget buildCustomDialogComplete() {
      double screenWidth = MediaQuery.of(context).size.width;

      return Container(
        padding: const EdgeInsets.all(
          35,
        ),
        width: screenWidth * 0.9375,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '탈퇴가 완료되었습니다.',
              style: TextStyle(
                fontFamily: 'GyeonggiTitleBold',
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '고객님의 정보는 정상적으로 파기 되었습니다. 남겨주신 의견을 바탕으로 더 나은 Appname이 되도록 노력하겠습니다. \n\n그동안 이용해주셔서 감사합니다.',
              textAlign: TextAlign.center, // 가운데 정렬
              style: TextStyle(
                fontFamily: 'GyeonggiTitleLight',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // 배경 투명
                    elevation: 0, // 그림자 제거
                    shadowColor: Colors.transparent, // 혹시 모를 그림자 제거
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontFamily: 'GyeonggiTitleBold',
                      color: Color(0xff363535),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      );
    }

    //정말로 탈퇴하시겠어요?
    Widget buildCustomDialog() {
      double screenWidth = MediaQuery.of(context).size.width;

      return Container(
        padding: const EdgeInsets.all(
          35,
        ),
        width: screenWidth * 0.9375,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '정말로 탈퇴 하시겠어요?',
              style: TextStyle(
                fontFamily: 'GyeonggiTitleBold',
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              '지금 탈퇴하면 정말로 \n데이터가 파기돼요.',
              style: TextStyle(
                fontFamily: 'GyeonggiTitleLight',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontFamily: 'GyeonggiTitleLight',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: buildCustomDialogComplete(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFAC632),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '탈퇴하기',
                      style: TextStyle(
                        fontFamily: 'GyeonggiTitleLight',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    String? selectedReason;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: const Text(
          '탈퇴하기',
          style: TextStyle(
            fontFamily: 'GyeonggiTitleBold',
            fontSize: 20,
            color: Color(0xff363535),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //탈퇴 주의사항 Title
            const Text(
              'App Name을 탈퇴하기 전에 \n 확인해주세요',
              style: TextStyle(
                fontFamily: 'GyeonggiTitleBold',
                fontSize: 20,
                color: Color(0xff363535),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //탈퇴 주의사항 Container
            Container(
                padding: const EdgeInsets.all(15.0),
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFAC632).withOpacity(0.3),
                ),
                child: Text.rich(
                  TextSpan(
                    text: '탈퇴가 완료되면 ',
                    style: TextStyle(
                      color: Color(0xff363535),
                      fontFamily: 'GyeonggiTitleLight',
                    ),
                    children: [
                      TextSpan(
                        text: '개인정보는 즉시 파기되며, 복구가 불가',
                        style: TextStyle(
                          fontFamily: 'GyeonggiTitleBold',
                        ),
                      ),
                      TextSpan(text: '해요.'),
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            ),

            //탈퇴사유 Title
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text('탈퇴 사유'),
            ),

            //탈퇴 사유 DropdownButtonForm
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xfffac632), // 포커스(클릭)됐을 때 테두리 색
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red, // 에러 발생 시 테두리 색
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xff887E7E), // 비활성 상태일 때 테두리 색
                    width: 1.5,
                  ),
                ),
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              hint: const Text(
                '탈퇴 사유를 입력해주세요.',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff887E7E),
                    fontFamily: 'GyeonggiTitle'),
              ),
              items: deleteMenuItems
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GyeonggiTitle',
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: selectedReason,
              onChanged: (value) {
                setState(() {
                  selectedReason = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return '탈퇴 사유를 선택해주세요.';
                }
                return null;
              },
              dropdownStyleData: const DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),

            const Spacer(),
            BasicLgButtonForText(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: buildCustomDialog(),
                  ),
                );
              },
              title: '탈퇴하기',
            )
          ],
        ),
      ),
    );
  }
}
