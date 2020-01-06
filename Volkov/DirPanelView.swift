//
//  DirPanelView.swift
//  Volkov
//
//  Created by cybek on 06/01/2020.
//  Copyright © 2020 cybek. All rights reserved.
//

import Cocoa

class DirPanelView: NSView, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet var contentView: NSView!
    @IBOutlet weak var filesTable: NSTableView!
    @IBOutlet weak var pathLabel: NSTextField!
    
    @IBOutlet weak var fileNameCell: NSTextFieldCell!
    @IBOutlet weak var fileNameColumn: NSTableColumn!
    
    var pathURL : URL
    var fileManager : FileManager
    var files : [URL] = []
    //var filesEnumerator : FileManager.DirectoryEnumerator
    
    override init(frame frameRect: NSRect) {
        
        fileManager = FileManager.default
        pathURL = fileManager.homeDirectoryForCurrentUser
        
        super.init(frame: frameRect)
        commonInit()
    }
    
    override required init?(coder: NSCoder) {
        
        fileManager = FileManager()
        pathURL = fileManager.homeDirectoryForCurrentUser
        
        super.init(coder: coder)
        commonInit()
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DirPanel", owner: self, topLevelObjects: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .width, .height ]
        
        filesTable.delegate = self
        filesTable.dataSource = self
        
        refreshFiles()
    }
    
    func refreshFiles() {
        pathLabel.stringValue = pathURL.absoluteString //.substring(to: pathURL.absoluteString.index(pathURL.absoluteString.startIndex, offsetBy: 5))
        
        files = try! fileManager.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        
        files.sort { (a, b) -> Bool in
            let nameA = a.lastPathComponent
            let nameB = b.lastPathComponent
            let dirA = a.hasDirectoryPath
            let dirB = b.hasDirectoryPath
            
            return (dirA == dirB) ? nameA < nameB : dirA
        }
        
        files.insert(pathURL.appendingPathComponent(".."), at: 0)
        
        filesTable.reloadData()
        filesTable.scrollRowToVisible(0)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        //let enumerator = fileManager.enumerator(at: pathURL, includingPropertiesForKeys: nil)
        //let count = enumerator!.underestimatedCount
        
        return files.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if tableColumn == fileNameColumn {
            let cell = tableView.makeView(withIdentifier: fileNameColumn.identifier, owner: self) as? NSTableCellView
            //let cell2 = tableView.makeView(withIdentifier: fileNameCell.identifier!, owner: self)
            cell?.textField?.stringValue = files[row].lastPathComponent
            
            NSLog("objectValueFor - \(files[row].lastPathComponent)")
            
            if files[row].hasDirectoryPath {
                return "[\(files[row].lastPathComponent)]"
            } else {
                return files[row].lastPathComponent
            }
            
            return files[row].lastPathComponent
            return cell
        }
        
        return "yolo"
    }
    
    @IBAction func fileDoubleClicked(_ sender: Any) {
        let row = filesTable.selectedRow
        
        if row < 0 || row >= files.count {
            return
        }
        
        if files[row].hasDirectoryPath {
            let dir = files[row]
            pathURL = dir.absoluteURL
            refreshFiles()
        } else {
            let file = files[row]
            NSWorkspace.shared.open(file)
        }
    }
    
}
