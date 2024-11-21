package com.fynesy.inventory;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@OpenAPIDefinition(
        info = @Info(
                title = "InventoryB Management API",
                version = "1.0"),
        tags = @Tag(
                name = "InventoryB REST API"))
@CrossOrigin
@RestController
public class InventoryController {


    @Operation(summary = "Get all inventory", method = "GET", tags = "InventoryB CRUD")
    @ApiResponses({
            @ApiResponse(
                    responseCode = "200",
                    description = "InventoryB retrieved successfully."
            )
    })
    @GetMapping({ "/api/inventory" })
    public String getAll() {
        System.out.println("all B inventory");
        return "all B inventory";
    }
    

    @Operation(summary = "Get site status", method = "GET", tags = "InventoryB CRUD")
    @ApiResponses({
            @ApiResponse(
                    responseCode = "200",
                    description = "Site status retrieved successfully."
            )
    })
    @GetMapping({ "/api/sites" })
    public String getSite() {
        System.out.println("all B sites");
        return "all B sites";
    }
}
