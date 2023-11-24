package com.quickmed.backend.controller;

import com.quickmed.backend.entities.PlanoDeSaude;
import com.quickmed.backend.service.PlanoSaudeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/planos-saude")
public class PlanoDeSaudeController {

    private final PlanoSaudeService planoDeSaudeService;

    @Autowired
    public PlanoDeSaudeController(PlanoSaudeService planoDeSaudeService) {
        this.planoDeSaudeService = planoDeSaudeService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlanoDeSaude> getPlanoDeSaude(@PathVariable Long id) {
        PlanoDeSaude planoDeSaude = planoDeSaudeService.getPlanoDeSaudeById(id);
        if (planoDeSaude != null) {
            return new ResponseEntity<>(planoDeSaude, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<PlanoDeSaude>> listarPlanosDeSaude() {
        List<PlanoDeSaude> planosDeSaude = planoDeSaudeService.listarPlanosDeSaude();
        return ResponseEntity.ok(planosDeSaude);
    }

    @PostMapping
    @Transactional
    public ResponseEntity<PlanoDeSaude> cadastrarPlanoDeSaude(@RequestBody PlanoDeSaude planoDeSaude) {
        PlanoDeSaude createdPlanoDeSaude = planoDeSaudeService.cadastrarPlanoDeSaude(planoDeSaude);
        return new ResponseEntity<>(createdPlanoDeSaude, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Transactional
    public ResponseEntity<PlanoDeSaude> atualizarPlanoDeSaude(@PathVariable Long id, @RequestBody PlanoDeSaude planoDeSaude) {
        PlanoDeSaude updatedPlanoDeSaude = planoDeSaudeService.atualizarPlanoDeSaude(id, planoDeSaude);
        if (updatedPlanoDeSaude != null) {
            return ResponseEntity.ok(updatedPlanoDeSaude);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
