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
    //num error checking
    func owoProofing() {
        var owo = [""]
        owo += mRNArr
        owo.remove(at: 0)
        var help = 0
        let count = owo.count
        for _ in 1...count {
            var num = 0
            for char in owo[0] {
                num += 1
            }
            if (num / 3) < 1 {
                help += 1
                print("△ Watch out: Codon \(owo[0]) is too short!")
            } else if (num / 3) > 1 || (num % 3) > 0 {
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
        for _ in 1...count {
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
    let codons = ["GGU","GGC","GGA","GGG","UUU","UUC","UUA","UUG","CUU","CUC","CUA","CUG","UCU","UCC","UCA","UCG","AGU","AGC","UAU","UAC","UGU","UGC","UGG","CCU","CCC","CCA","CCG","CAU","CAC","CAA","CAG","CGU","CGC","CGA","CGG","AGA","AGG","AUA","AUC","AUU","AUG","ACG","ACA","ACC","ACU","AAU","AAC","AAA","AAG","GUU","GUC","GUA","GUG","GCU","GCC","GCA","GCG","GAU","GAC","GAA","GAG","UAA","UAG","UGA"]
    let aminoA = ["Gly","Gly","Gly","Gly","Phe","Phe","Leu","Leu","Leu","Leu","Leu","Leu","Ser","Ser","Ser","Ser","Ser","Ser","Tyr","Tyr","Cys","Cys","Try","Pro","Pro","Pro","Pro","His","His","Glu","Glu","Arg","Arg","Arg","Arg","Arg","Arg","Iso","Iso","Iso","Met","Thr","Thr","Thr","Thr","Asp","Asp","Lys","Lys","Val","Val","Val","Val","Ala","Ala","Ala","Ala","AspAc","AspAc","GluAc","GluAc","Stop","Stop","Stop"]
    let someDictionary = Dictionary(uniqueKeysWithValues: zip(codons,aminoA))
    for _ in 1...mcount {
        if var current2 = someDictionary[mRNArr[0]] {
            current2 = current2.replacingOccurrences(of: "Optional", with: "", options: NSString.CompareOptions.literal, range: nil)
            protein += [current2]
            current2 = ""
        }
        mRNArr.remove(at: 0)
    }
    print("〉The amino acid chain consists of \(protein).")
    var finalError = 1
    func final() {
        finalError = 0
        print("〉Type key to show the full amino acid names, or type quit to quit (case sensitive)")
        if let uhh2 = readLine() {
            if uhh2 == "key" {
                var expanded = [""]
                expanded.remove(at: 0)
                let min = ["Gly","Phe","Leu","Ser","Tyr","Cys","Try","Pro","His","Glu","Arg","Iso","Met","Thr","Asp","Lys","Val","Ala","AspAc","GluAc","Stop"]
                let max = ["Glycine","Phenylalanine","Leucine","Serine","Tyrosine","Cysteine","Trytophan","Proline","Histidine","Glutamine","Arginine","Isoleucine","Methionine","Threonine","Asparagine","Lysine","Valine","Alanine","Aspartic acid","Glutamic acid","Stop"]
                let secondDictionary = Dictionary(uniqueKeysWithValues: zip(min,max))
                for _ in 1...mcount {
                    if var current3 = secondDictionary[protein[0]] {
                        current3 = current3.replacingOccurrences(of: "Optional", with: "", options: NSString.CompareOptions.literal, range: nil)
                        expanded += [current3]
                        current3 = ""
                    }
                    protein.remove(at: 0)
                }
                print("〉The amino acid chain consists of \(expanded).")
            } else if uhh2 == "quit" {
                print("〉Program exited.")
                exit(0)
            } else {
                finalError += 1
                print("ⓧ Invalid input; please try again.")
            }
        }
    }
    while finalError > 0 {
        final()
    }
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
