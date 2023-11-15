# CleanUpPS1
Clean up powershell scripts (using Linux only)

## Usage:

### One-time setup:
Once this is done you do not have to repeat it with the same powershell script:
1. Verify .sh scripts have correct perms :) ``chmod +x`` them if needed.
2. ``sed -n -e 's/[^"]*"\([^"]*\)"/\1\n/gp' script.ps1 > PotentiallyBadStrings.txt``
3. ``cat PotentiallyBadStrings.txt | sort -u > UniquePotentiallyBadStrings.txt`` 
4. Manually examine the ``UniquePotentiallyBadStrings.txt`` strings add strings that should be replaced or remove unnecessary words that should not be replaced & save a new file called ``BadStrings.txt``
5. Remove comments: ``sed -i -e '/<#/,/#>/c\\' script.ps1``
6. Remove in-line comments (verify it works afterwards): ``sed -i '/^[ \t]*#/d; s/#[^"]*$//' script.ps1``


### Replace double-quoted stuff:
(use every time re-using a ps script)
1. The 60 is arbitrary number of max random words that will be used to replace the bad strings.``./Scripts/GenerateGoodString.sh $(wc -l BadStrings.txt) cleanwords.txt 60 > GoodStrings.txt``
2. ``awk 'NR==FNR {gsub(/[\&:]/, "\\\\&"); a[NR]=$0; next} {gsub(/[\&:]/, "\\\\&"); print "s:"a[FNR]":"$0":g"}'  BadStrings.txt GoodStrings.txt > script.sed``
3. ``sed -f script.sed script.ps1 > change1.ps1``

### Sprinking random comments thoughout the code:
increasing the file-size & decreasing entropy
(use every time re-using a ps script)
1. ``shuf cleanwords.txt | head -n 40 > smallwords.txt``
2. ``./Scripts/AddRandomComments.sh change1.ps1 smallwords.txt 200 1000``

### Creating your own dictionary:
1. Find a dictionary you like by googling: ``dictionary filetype:txt site:github.com``
2. Keep use only alphabetic entries, between 2 and 10 characters: ``grep -E '^[[:alpha:]]{2,10}$' words.txt | sort -u > cleanwords.txt``
3. If you have time, read through the words manually, to remove bad words & suspicious entries.


## Disclaimer for "CleanUpPS1":

### Summary: 
Don't be an idiot and be responsible with usage. Pentesting without authorization is illegal.

### In depth: 
1. General Use: This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
2. Potential Misuse: The software is designed for legitimate purposes only. Any misuse, including but not limited to illegal, unethical, or unauthorized activities, is strictly discouraged and not the intention of the developers.
3. User Responsibility: Any person, entity, or organization choosing to use this software bears the full responsibility for its actions while using the software. It is the user's responsibility to ensure that their use of this software complies with local, state, national, and international laws and regulations.
4. No Liability: The creators, developers, and distributors of this software are not responsible for any harm or damage caused, directly or indirectly, by the misuse or use of this software.
5. Updates and Monitoring: The developers reserve the right to update, modify, or discontinue the software at any time. Users are advised to always use the most recent version of the software. However, even with updates, the developers cannot guarantee that the software is completely secure or free from vulnerabilities.
6. Third-Party Software/Links: This software may contain links to third-party sites or utilize third-party software/tools. The developers are not responsible for the content or privacy practices of those sites or software.
7. Unauthorized Access: Using "CleanUpPS1" to access, probe, or connect to systems, networks, or data without explicit permission from appropriate parties is strictly discouraged, unethical, and illegal. Unauthorized access to systems, networks, or data breaches various local, national, and international laws, and can result in severe legal consequences. Always obtain the necessary permissions before accessing any systems or data. The developers of "CleanUpPS1" disavow any actions taken by individuals or entities that use this software for unauthorized activities.

By downloading, installing, or using "CleanUpPS1" you acknowledge that you have read, understood, and agreed to abide by this disclaimer. If you do not agree to these terms, do not use the software.
