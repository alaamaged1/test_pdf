import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

List<GetMcqQuestionModel> qQ = [
  GetMcqQuestionModel(
    question: "_______________ is one of the key components of compute system",
    choice1: "option 1",
    choice2: "Option 2",
    choice3: "Option 3",
    choice4: "Option 4",
  ),
  GetMcqQuestionModel(
    question:
        "________ is a group of severs that consumes floor spaceis a group of severs that consumes floor spaceis a group of severs that consumes floor spaceis a group of severs that consumes floor spaceis a group of severs that consumes floor space, requires complex cabling, and generates noise from cooling units.",
    choice1: "option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question:
        "__________ is a storage technique in which data is written in blocks across multiple disk drives",
    choice1: "Option 1",
    choice2: "Option 2",
    choice3: "Option 3",
    choice4: "Option 4",
  ),
  GetMcqQuestionModel(
    question:
        "__________ use stripped data with parallel access and dedicated parity disk.",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
  GetMcqQuestionModel(
    question: "Question 4",
    choice1: "Option A",
    choice2: "Option B",
    choice3: "Option C",
    choice4: "Option D",
  ),
];

class ExamPdfGenerator {
  static Future<void> generateAndDownloadExam() async {
    // Create a PDF document
    final pdf = pw.Document();

    final cairoUniLogo = await _fetchcairoUniLogo(
        'https://th.bing.com/th/id/OIP.xr9y1bplJM6Ot5z_dZmamwHaHa?w=175&h=180&c=7&r=0&o=5&pid=1.7');
    final facultyLogo = await _fetchcairoUniLogo(
        'https://th.bing.com/th/id/OIP.2HWpWeb1RTRUUP6VsJtsOAHaGy?w=197&h=180&c=7&r=0&o=5&pid=1.7');

    // Add content to the PDF
    _addPageContent(pdf, cairoUniLogo, facultyLogo);
    // Save the PDF as a Uint8List
    final Uint8List pdfBytes = await pdf.save();

    // Convert Uint8List to Blob
    final blob = html.Blob([pdfBytes], 'application/pdf');

    // Create a download link
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'sample_exam.pdf'
      ..click();

    // Clean up
    html.Url.revokeObjectUrl(url);
  }

  static void _addPageContent(
      pw.Document pdf, Uint8List cairoUniLogo, Uint8List facultyLogo) {
    // Add content to the PDF
    final pageContent = pw.MultiPage(
      build: (context) => [
        // Header
        // _buildHeader(),

        pw.Row(children: [
          pw.Container(
            child: pw.Image(pw.MemoryImage(cairoUniLogo)),
          ),
          pw.SizedBox(
            width: 110,
          ),
          pw.Container(
            width: 180,
            height: 240,
            child: pw.Image(pw.MemoryImage(facultyLogo)),
          ),
        ]),

        // Title of the exam

        pw.Center(
          child: pw.Text("Electronics",
              style:
                  pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        ),

        pw.SizedBox(height: 20),

        // Exam Information
        _buildExamInfo(
            "Faculty of Computer and Artificial Intelligence,",
            "Software Engineering",
            "CS201",
            "Prof. Elham Shawky",
            "2024/1/1",
            "2 hours"),
        pw.Text(' Choose the correct answer:',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 13,
              decoration: pw.TextDecoration.underline,
            )),
        pw.SizedBox(height: 5),
        _buildMultipleChoiceQuestions(qQ),
        // Question 1
        // _buildMultipleChoiceQuestion("1. What is the capital of France?",
        //     ["A. London", "B. Paris", "C. Berlin", "D. Madrid"]),
        pw.SizedBox(height: 10),

        // Question 2
        // _buildMultipleChoiceQuestion(
        //     "2. Which planet is known as the Red Planet?",
        //     ["A. Venus", "B. Mars", "C. Jupiter", "D. Saturn"]),
        pw.SizedBox(height: 10),

        // Essay Question 1
        // _buildEssayQuestion(
        //     "3. Explain the concept of object-oriented programming."),
        // pw.SizedBox(height: 10),

        // // Essay Question 2
        // _buildEssayQuestion(
        //     "4. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "5. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "6. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "7. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "8. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "9. Discuss the importance of software testing in software development."),
        // _buildEssayQuestion(
        //     "10. Discuss the importance of software testing in software development."),
      ],
    );

    pdf.addPage(pageContent);
  }

//!don't use Header.
  static pw.Widget _buildHeader() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
                "Faculty : Faculty of Computer and Artificial Intelligence"),
            pw.Text("Subject : Software Engineering"),
            pw.Text("Course ID: CS201"),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("Professor Name: Prof. Elham Shawky"),
            pw.Text("Date: 2024/1/1"),
            pw.Text("Time: 2 hours"),
          ],
        ),
      ],
    );
  }

  static Future<Uint8List> _fetchcairoUniLogo(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  static pw.Widget _buildExamInfo(String facultyName, String subjectName,
      String courseId, String professorName, String date, String time) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(children: []),
          pw.Text("Faculty Name: $facultyName"),
          pw.Row(
            // mainAxisAlignment: MainAxisAlignment.
            children: [
              pw.Text("Subject Name: $subjectName"),
              pw.SizedBox(width: 120),
              pw.Text("Course ID: $courseId"),
            ],
          ),
          pw.Row(
              // mainAxisAlignment: pw.MainAxisAlignment.space,
              children: [
                pw.Text("Professor Name: $professorName"),
                pw.SizedBox(width: 120),
                pw.Text("Date: $date"),
              ]),
          pw.Text("Time: $time"),
        ],
      ),
    );
  }

  // static pw.Widget _buildMultipleChoiceQuestion(
  //     {required String question,
  //     required String chooice1,
  //     required String chooice2,
  //     required String chooice3,
  //     required String chooice4}) {
  //   return pw.Container(
  //     margin: const pw.EdgeInsets.only(bottom: 20),
  //     child: pw.Column(
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       children: [
  //         // Question
  //         pw.Text(question,
  //             style:
  //                 pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 5),

  //         // Options
  //         pw.Row(children: [
  //           pw.Text(chooice1),
  //           pw.SizedBox(width:50),
  //           pw.Text(chooice2),
  //         ]),
  //         pw.Row(children: [
  //           pw.Text(chooice3),
  //           pw.SizedBox(width: 50),
  //           pw.Text(chooice4),
  //         ])
  //       ],
  //     ),
  //   );
  // }

  static pw.Widget _buildMultipleChoiceQuestions(
      List<GetMcqQuestionModel> questions) {
    return pw.ListView.builder(
      itemBuilder: (context, index) {
        final question = questions[index];
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Question
              pw.Row(children: [
                pw.Flexible(
                  child: pw.Text(
                    "${index + 1}.${question.question}",
                    style: const pw.TextStyle(fontSize: 12, lineSpacing: 3),
                  ),
                ),
              ]),

              pw.SizedBox(height: 5),

              // Options
              pw.Row(
                children: [
                  pw.Text(
                    "A)     ${question.choice1.substring(0, 1).toUpperCase()}${question.choice1.substring(1)}",
                    style: const pw.TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  pw.SizedBox(width: 200),
                  pw.Text(
                    "B)     ${question.choice2.substring(0, 1).toUpperCase()}${question.choice2.substring(1)}",
                    style: const pw.TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Row(
                children: [
                  pw.Text(
                    "C)     ${question.choice3.substring(0, 1).toUpperCase()}${question.choice3.substring(1)}",
                    style: const pw.TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  pw.SizedBox(width: 200),
                  pw.Text(
                    "D)     ${question.choice4.substring(0, 1).toUpperCase()}${question.choice4.substring(1)}",
                    style: const pw.TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: questions.length,
    );
  }

  static pw.Widget _buildEssayQuestion(
      String question, bool isAnswerInSamePaper) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Question
          pw.Text(question,
              style:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),

          // Answer space for the essay question
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            width: double.infinity,
            height: 100, // You can adjust the height based on your preference
            child: pw.Text(
                "Answer: ________________________________________________"),
          ),
        ],
      ),
    );
  }
}

class GetMcqQuestionModel {
  String question;
  String choice1;
  String choice2;
  String choice3;
  String choice4;

  GetMcqQuestionModel({
    required this.question,
    required this.choice1,
    required this.choice2,
    required this.choice3,
    required this.choice4,
  });
}
