#!/usr/bin/env python3
"""Generate a PDF report from the Bluetooth car project summary."""

from pathlib import Path
from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import mm
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Preformatted, PageBreak
)

ROOT = Path(__file__).resolve().parent
SUMMARY = ROOT / "results_summary.txt"
OUTPUT = ROOT / "bluetooth_Final_Report.pdf"

def main():
    if not SUMMARY.exists():
        raise FileNotFoundError(f"Missing summary file: {SUMMARY}")

    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(
        name="ReportTitle", parent=styles["Title"],
        alignment=TA_CENTER, textColor=colors.HexColor("#12345A"),
        fontSize=18, leading=23, spaceAfter=14
    ))
    styles.add(ParagraphStyle(
        name="SectionHeading", parent=styles["Heading2"],
        textColor=colors.HexColor("#12345A"),
        spaceBefore=8, spaceAfter=5
    ))
    styles.add(ParagraphStyle(
        name="ReportBody", parent=styles["BodyText"],
        fontSize=9, leading=13, spaceAfter=5
    ))

    doc = SimpleDocTemplate(
        str(OUTPUT), pagesize=A4,
        rightMargin=20*mm, leftMargin=20*mm,
        topMargin=18*mm, bottomMargin=18*mm,
        title="Bluetooth-Controlled Car Using UART RTL"
    )

    story = [
        Paragraph("Bluetooth-Controlled Car Using UART RTL", styles["ReportTitle"]),
        Paragraph(
            "RTL Design and Physical-Design Project Summary",
            styles["Heading2"]
        ),
        Spacer(1, 8),
        Paragraph(
            "This report documents the project architecture and points "
            "to the project's simulation and OpenLane reports. Physical "
            "hardware operation and numerical PPA results are not claimed "
            "unless supported by recorded evidence.",
            styles["ReportBody"]
        ),
        Spacer(1, 8),
    ]

    for line in SUMMARY.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if not stripped:
            story.append(Spacer(1, 4))
        elif stripped and set(stripped) <= {"="}:
            continue
        elif stripped.isupper() and len(stripped) > 3 and not ":" in stripped:
            story.append(Paragraph(stripped, styles["SectionHeading"]))
        else:
            story.append(Preformatted(line, styles["Code"]))

    def footer(canvas, document):
        canvas.saveState()
        canvas.setFont("Helvetica", 8)
        canvas.setFillColor(colors.grey)
        canvas.drawString(20*mm, 10*mm, "Bluetooth Car Controller | UART RTL")
        canvas.drawRightString(A4[0] - 20*mm, 10*mm, f"Page {document.page}")
        canvas.restoreState()

    doc.build(story, onFirstPage=footer, onLaterPages=footer)
    print(f"Report created: {OUTPUT}")

if __name__ == "__main__":
    main()
