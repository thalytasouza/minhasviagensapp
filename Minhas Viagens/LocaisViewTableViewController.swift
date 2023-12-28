import UIKit

class LocaisViewTableViewController: UITableViewController {
    
    var locaisViagens: [Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        atualizarViagens()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locaisViagens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viagem = locaisViagens[ indexPath.row ]["local"]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        celula.textLabel?.text = viagem
        
        return celula
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            ArmazenamentoDados().removerViagem( indice: indexPath.row )
            atualizarViagens()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "verLocal", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verLocal"{
            
            let viewControllerDestino = segue.destination as! ViewController
            if let indiceRecuperado = sender {
                
                let indice = indiceRecuperado as! Int
                viewControllerDestino.viagem = locaisViagens[ indice ]
                viewControllerDestino.indiceSelecionado = indice
                
            }
            
        }
    }
    
    func atualizarViagens(){
        locaisViagens = ArmazenamentoDados().listarViagens()
        tableView.reloadData()
    }
}
