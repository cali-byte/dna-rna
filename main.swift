import Foundation
import Darwin
// Made by Rttiik Ghohs, in May 2019
func shell(_ command: String) -> String {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", command]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    print("\(output)")
    return output
}

shell("clear")

var error = 0

func transcribe() {
    print("〉Enter the template DNA, then hit return (type A, T, G or C, no spaces)")
    
    var templateDNA = ""
    if let owoawuowo = readLine() {
        templateDNA += owoawuowo
        print("〉The given template DNA was \(owoawuowo)")
    }
    var mRNA = ""
    for char in templateDNA {
        if char == "A" || char == "a" {
            mRNA += "U"
        } else if char == "T" || char == "t" {
            mRNA += "A"
        } else if char == "G" || char == "g" {
            mRNA += "C"
        } else if char == "C" || char == "c" {
            mRNA += "G"
        } else {
            print ("△ Invalid character \(char) entered!")
            error += 1}
    }
    if error < 1 {
        print("〉After transcription, the mRNA strand is \(mRNA)")
    } else {
        print("ⓧ Program halted due to an invalid character.")
        exit(0)
    }
}

func translate() {
    print("〉Enter the mRNA, then hit return. Separate each codon with a space. (A, U, G, C, case sensitive)")
    var mRNA = ""
    if let uhhh = readLine() {
        mRNA += uhhh
        print("〉The given mRNA was \(uhhh).")
    }
    var mRNArr = [""]
    mRNArr += mRNA.components(separatedBy: " ")
    mRNArr.remove(at: 0)
    let aminoAcids = ["Gly","Phe","Leu","Ser","Tyr","Cys","Try","Pro","His","Glu","Arg","Iso","Met","Thr","Asp","Lys","Val","Ala","AspAc","GluAc","Stop"]
    //num error checking
    func owoProofing() {
        var owo = [""]
        owo += mRNArr
        owo.remove(at: 0)
        var help = 0
        let count = owo.count
        for i in 1...count {
            var num = 0
            for char in owo[0] {
                num += 1
            }
            if (num / 3) < 1 {
                help += 1
                print("△ Watch out: Codon \(owo[0]) is too short!")
            } else if (num / 3) > 1 || (num % 3) > 0 {
                var aaa = num / 3
                help += 1
                print("△ Watch out: Codon \(owo[0]) is too long!")
            }
            owo.remove(at: 0)
        }
        if help > 0 {
            print("ⓧ A codon was too long/short. Program halted.")
            exit(0)
        }
    }
    //char error checking
    func uwuProofing() {
        var uwu = [""]
        uwu += mRNArr
        uwu.remove(at: 0)
        var reallyHelp = 0
        let count = uwu.count
        for i in 1...count {
            for char in uwu[0] {
                if char != "A" && char != "U" && char != "G" && char != "C" {
                    reallyHelp += 1
                    print("△ Invalid character \(char) entered!")
                }
            }
            uwu.remove(at: 0)
        }
        if reallyHelp > 0 {
            print("ⓧ Program halted due to an invalid character.")
            exit(0)
        }
    }
    owoProofing()
    uwuProofing()
    //actual translation
    var protein = [""]
    protein.remove(at: 0)
    let mcount = mRNArr.count
    for i in 1...mcount {
        if mRNArr[0] == "GGU" || mRNArr[0] == "GGC" || mRNArr[0] == "GGA" || mRNArr[0] == "GGG" {
            protein += [aminoAcids[0]] //Gly
        } else if mRNArr[0] == "UUU" || mRNArr[0] == "UUC" {
            protein += [aminoAcids[1]] //Phe
        } else if mRNArr[0] == "UUA" || mRNArr[0] == "UUG" || mRNArr[0] == "CUU" || mRNArr[0] == "CUC" || mRNArr[0] == "CUA" || mRNArr[0] == "CUG" {
            protein += [aminoAcids[2]] //Leu
        } else if mRNArr[0] == "UCU" || mRNArr[0] == "UCC" || mRNArr[0] == "UCA" || mRNArr[0] == "UCG" || mRNArr[0] == "AGU" || mRNArr[0] == "AGC" {
            protein += [aminoAcids[3]] //Ser
        } else if mRNArr[0] == "UAU" || mRNArr[0] == "UAC" {
            protein += [aminoAcids[4]] //Tyr
        } else if mRNArr[0] == "UGU" || mRNArr[0] == "UGC" {
            protein += [aminoAcids[5]] //Cys
        } else if mRNArr[0] == "UGG" {
            protein += [aminoAcids[6]] //Try
        } else if mRNArr[0] == "CCU" || mRNArr[0] == "CCC" || mRNArr[0] == "CCA" || mRNArr[0] == "CCG" {
            protein += [aminoAcids[7]] //Pro
        } else if mRNArr[0] == "CAU" || mRNArr[0] == "CAC" {
            protein += [aminoAcids[8]] //His
        } else if mRNArr[0] == "CAA" || mRNArr[0] == "CAG" {
            protein += [aminoAcids[9]] //Glu
        } else if mRNArr[0] == "CGU" || mRNArr[0] == "CGC" || mRNArr[0] == "CGA" || mRNArr[0] == "CGG" || mRNArr[0] == "AGA" || mRNArr[0] == "AGG" {
            protein += [aminoAcids[10]] //Arg
        } else if mRNArr[0] == "AUA" || mRNArr[0] == "AUC" || mRNArr[0] == "AUU" {
            protein += [aminoAcids[11]] //Iso
        } else if mRNArr[0] == "AUG" {
            protein += [aminoAcids[12]] //Met
        } else if mRNArr[0] == "ACG" || mRNArr[0] == "ACA" || mRNArr[0] == "ACC" || mRNArr[0] == "ACU" {
            protein += [aminoAcids[13]] //Thr
        } else if mRNArr[0] == "AAU" || mRNArr[0] == "AAC" {
            protein += [aminoAcids[14]] //Asp
        } else if mRNArr[0] == "AAA" || mRNArr[0] == "AAG" {
            protein += [aminoAcids[15]] //Lys
        } else if mRNArr[0] == "GUU" || mRNArr[0] == "GUC" || mRNArr[0] == "GUA" || mRNArr[0] == "GUG" {
            protein += [aminoAcids[16]] //Val
        } else if mRNArr[0] == "GCU" || mRNArr[0] == "GCC" || mRNArr[0] == "GCA" || mRNArr[0] == "GCG" {
            protein += [aminoAcids[17]] //Ala
        } else if mRNArr[0] == "GAU" || mRNArr[0] == "GAC" {
            protein += [aminoAcids[18]] //AspAc
        } else if mRNArr[0] == "GAA" || mRNArr[0] == "GAG" {
            protein += [aminoAcids[19]] //GluAc
        } else if mRNArr[0] == "UAA" || mRNArr[0] == "UAG" || mRNArr[0] == "UGA" {
            protein += [aminoAcids[20]] //(of an event, action, or process) come to an end; cease to happen
        }
        mRNArr.remove(at: 0)
    }
    print("〉The amino acid chain consists of \(protein).")
    func final() {
        var finalError = 0
        print("〉Type key to show the full amino acid names, or type quit to quit (case sensitive)")
        if let uhh2 = readLine() {
            if uhh2 == "key" {
                var expanded = [""]
                expanded.remove(at: 0)
                for i in 1...mcount {
                    if protein[0] == "Gly" {
                        expanded += ["Glycine"]
                    } else if protein[0] == "Phe" {
                        expanded += ["Phenylalanine"]
                    } else if protein[0] == "Leu" {
                        expanded += ["Leucine"]
                    } else if protein[0] == "Ser" {
                        expanded += ["Serine"]
                    } else if protein[0] == "Tyr" {
                        expanded += ["Tyrosine"]
                    } else if protein[0] == "Cys" {
                        expanded += ["Cysteine"]
                    } else if protein[0] == "Try" {
                        expanded += ["Trytophan"]
                    } else if protein[0] == "Pro" {
                        expanded += ["Proline"]
                    } else if protein[0] == "His" {
                        expanded += ["Histidine"]
                    } else if protein[0] == "Glu" {
                        expanded += ["Glutamine"]
                    } else if protein[0] == "Arg" {
                        expanded += ["Arginine"]
                    } else if protein[0] == "Iso" {
                        expanded += ["Isoleucine"]
                    } else if protein[0] == "Met" {
                        expanded += ["Methionine"]
                    } else if protein[0] == "Thr" {
                        expanded += ["Threonine"]
                    } else if protein[0] == "Asp" {
                        expanded += ["Asparagine"]
                    } else if protein[0] == "Lys" {
                        expanded += ["Lysine"]
                    } else if protein[0] == "Val" {
                        expanded += ["Valine"]
                    } else if protein[0] == "Ala" {
                        expanded += ["Alanine"]
                    } else if protein[0] == "AspAc" {
                        expanded += ["Aspartic acid"]
                    } else if protein[0] == "GluAc" {
                        expanded += ["Glutamic acid"]
                    } else if protein[0] == "Stop" {
                        expanded += ["Stop"]
                    }
                    protein.remove(at: 0)
                }
                print("〉The amino acid chain consists of \(expanded).")
            } else if uhh2 == "quit" {
                print("〉Program exited.")
                exit(0)
            } else {
                finalError += 1
                print("")
            }
        }
    }
    final()
}

print("〉Type transcribe to transcribe, translate to translate, quit to quit (case sensitive)")
var e: String = ""

while e != "transcribe" || e != "translate" {
    if let aaa: String = readLine() {
        if aaa == "transcribe" {
            e += aaa
            print("〉Now in transcription mode.")
            break
        } else if aaa == "translate" {
            e += aaa
            print("〉that's not supported yet")
            break
        } else if aaa == "quit" {
            print("〉Program exited.")
            exit(0)
        } else {
            print("ⓧ Invalid input; please try again.")
        }
    }
}

if e == "transcribe" {
    transcribe()
} else if e == "translate" {
    translate()
}
